
/*
    Data from Databricks COVID-19 Dataset 
    "/databricks-datasets/COVID/covid-19-data/us_states.csv"
*/

{{ config(materialized='table') }}

WITH source AS (

  SELECT *
  FROM {{ source('raw', 'databricks_covid_mask_use') }}

), renamed AS (

  SELECT 
    countyfp AS fips_county_code,
    never AS never
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