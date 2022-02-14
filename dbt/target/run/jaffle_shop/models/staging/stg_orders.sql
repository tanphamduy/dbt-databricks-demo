
  create or replace  view OMG.PUBLIC.stg_orders 
  
   as (
    with source as (
    select * from OMG.PUBLIC.raw_orders

)

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from source
  );
