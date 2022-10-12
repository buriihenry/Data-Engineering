
    
    

with dbt_test__target as (

  select tripid as unique_field
  from `bamboo-autumn-360913`.`dbt_buriihenry`.`stg_yellow_tripdata`
  where tripid is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


