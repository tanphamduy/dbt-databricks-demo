with source as (

    {#-
    Data loaded from dbt seed
    #}
    select * from {{ ref('raw_customers') }}

)

    select
        id as customer_id,
        first_name,
        last_name
    from source
