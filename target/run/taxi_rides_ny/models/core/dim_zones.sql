

  create or replace table `bamboo-autumn-360913`.`dbt_buriihenry`.`dim_zones`
  
  
  OPTIONS()
  as (
    

select 
    locationid,
    borough,
    zone,
    replace(service_zone,'Boro','Green') as service_zone
from `bamboo-autumn-360913`.`dbt_buriihenry`.`taxi_zone_lookup`
  );
  