
/*
    Data from Databricks COVID-19 Dataset 
    "/databricks-datasets/COVID/covid-19-data/us.csv"
*/

{{ config(materialized='table') }}

WITH source AS (

  SELECT *
  FROM {{ source('raw', 'databricks_covid_us') }}

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