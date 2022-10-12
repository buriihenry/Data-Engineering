select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select tripid
from `bamboo-autumn-360913`.`dbt_buriihenry`.`stg_green_tripdata`
where tripid is null



      
    ) dbt_internal_test