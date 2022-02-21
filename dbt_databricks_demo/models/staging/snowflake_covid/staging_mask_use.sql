
/*
    Data from NY Times COVID-19 Dataset 
    "https://raw.githubusercontent.com/nytimes/covid-19-data/master/mask-use/mask-use-by-county.csv"
*/

{{ config(materialized='table') }}

WITH source AS (

  SELECT *
  FROM {{ source('raw', 'external_nytimes_covid_mask_use') }}

), renamed AS (

  SELECT 
    countyfp AS fips_county_code,
    never AS never,
    rarely AS rarely,
    sometimes AS sometimes,
    frequently AS frequently,
    always AS always


  FROM source
  {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  WHERE query_start_time > (SELECT MAX(query_start_time)  FROM {{ this }})

  {% endif %}
  
)

SELECT * 
FROM renamed