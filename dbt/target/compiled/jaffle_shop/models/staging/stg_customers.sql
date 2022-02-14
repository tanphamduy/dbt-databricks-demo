with source as (
    select * from OMG.PUBLIC.raw_customers

)

    select
        id as customer_id,
        first_name,
        last_name
    from source