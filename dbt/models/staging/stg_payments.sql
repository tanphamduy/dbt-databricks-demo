with source as (
    
    {#-
    Data loaded from dbt seed
    #}
    select * from {{ ref('raw_payments') }}

)

    select
        id as payment_id,
        order_id,
        payment_method,
        --`amount` is currently stored in cents, so we convert it to dollars
        amount / 100 as amount
    from source