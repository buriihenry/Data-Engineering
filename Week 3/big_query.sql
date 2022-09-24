-- Big Query SQL 

-- Creating external table referring to gcs path
-- bamboo-autumn-360913 (Project_name)
-- nytaxi (Dataset Name)
CREATE OR REPLACE EXTERNAL TABLE `bamboo-autumn-360913.nytaxi.external_yellow_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://transfer_service_gcp/trip data/yellow_tripdata_2019-*.parquet', 'gs://transfer_service_gcp/trip data/yellow_tripdata_2020-*.parquet']
);

-- Check yellow trip data
-- except exludes the column name

SELECT * except(airport_fee) FROM `bamboo-autumn-360913.nytaxi.external_yellow_tripdata` LIMIT 1000;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE bamboo-autumn-360913.nytaxi.yellow_tripdata_non_partitoned AS
SELECT * except(airport_fee) FROM bamboo-autumn-360913.nytaxi.external_yellow_tripdata;
