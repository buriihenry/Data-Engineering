

  create or replace view `bamboo-autumn-360913`.`dbt_buriihenry`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `bamboo-autumn-360913`.`dbt_buriihenry`.`my_first_dbt_model`
where id = 1;

