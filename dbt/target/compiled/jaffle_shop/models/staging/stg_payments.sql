with source as (
    select * from OMG.PUBLIC.raw_payments

)

    select
        id as payment_id,
        order_id,
        payment_method,
        --`amount` is currently stored in cents, so we convert it to dollars
        amount / 100 as amount
    from source