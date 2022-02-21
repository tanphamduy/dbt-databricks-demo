
/*
    Data from NY Times COVID-19 Dataset 
    "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"
*/

{{ config(materialized='table') }}

WITH source AS (

  SELECT *
  FROM {{ source('raw', 'external_nytimes_covid_us') }}

), renamed AS (

  SELECT 
    date AS date,
    cases AS cases,
    deaths AS deaths


  FROM source
  {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  WHERE query_start_time > (SELECT MAX(query_start_time)  FROM {{ this }})

  {% endif %}
  
)

SELECT * 
FROM renamed