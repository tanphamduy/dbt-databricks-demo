{% set payment_method_list = [
    "coupon",
    "credit_card",
    "bank_transfer"
] %}

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
        amount / 100 as amount,
        {% for payment_method in payment_method_list %}
        amount / 100 as amount_{{payment_method}}
        {% if not loop.last %}
        ,
        {% endif %}
        {% endfor %}
    from source