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

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * except(airport_fee) FROM bamboo-autumn-360913.nytaxi.external_yellow_tripdata;

-- Impact of partition
-- Scanning 1.6GB of data
SELECT DISTINCT(VendorID)
FROM bamboo-autumn-360913.nytaxi.yellow_tripdata_non_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Scanning ~106 MB of DATA
SELECT DISTINCT(VendorID)
FROM bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Let's look into the partitons
SELECT table_name, partition_id, total_rows
FROM `nytaxi.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_partitoned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned_clustered
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * except(airport_fee) FROM bamboo-autumn-360913.nytaxi.external_yellow_tripdata;

-- Query scans 1.1 GB
SELECT count(*) as trips
FROM bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;

-- Query scans 864.5 MB
SELECT count(*) as trips
FROM bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned_clustered
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;

-- Query scans 864.5 MB
