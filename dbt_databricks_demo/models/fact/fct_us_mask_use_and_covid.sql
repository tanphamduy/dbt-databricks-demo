
{{ config(materialized='table') }}

with us_counties
  as (select * from {{ ref('staging_us_counties') }}
        ),
     mask_use
   as (select * from {{ ref('staging_mask_use') }} 
        ),
     fct_us_mask_use_and_covid
     as 
     (select 
       c.date,
       c.county,
       c.state,
       c.cases,
       c.deaths,
       m.never,
       m.rarely,
       m.sometimes,
       m.frequently,
       m.always
  from us_counties c
  join mask_use m
    on c.fips_county_code = m.fips_county_code

  {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  WHERE query_start_time > (SELECT MAX(query_start_time)  FROM {{ this }})

  {% endif %}

    )

select * 
  from fct_us_mask_use_and_covid;
     