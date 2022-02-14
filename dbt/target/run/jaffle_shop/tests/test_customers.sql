select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      select count(1) from OMG.PUBLIC.customers
where number_of_orders is null
      
    ) dbt_internal_test