
  create or replace  view OMG.PUBLIC.stg_customers 
  
   as (
    with source as (
    select * from OMG.PUBLIC.raw_customers

)

    select
        id as customer_id,
        first_name,
        last_name
    from source
  );
