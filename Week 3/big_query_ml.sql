-- SELECT THE COLUMNS INTERESTED FOR YOU
SELECT passenger_count, trip_distance, PULocationID, DOLocationID, payment_type, fare_amount, tolls_amount, tip_amount
FROM `bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned` WHERE fare_amount != 0;

-- CREATE A ML TABLE WITH APPROPRIATE TYPE
CREATE OR REPLACE TABLE `bamboo-autumn-360913.nytaxi.yellow_tripdata_ml` (
`passenger_count` INTEGER,
`trip_distance` FLOAT64,
`PULocationID` STRING,
`DOLocationID` STRING,
`payment_type` STRING,
`fare_amount` FLOAT64,
`tolls_amount` FLOAT64,
`tip_amount` FLOAT64
) AS (
SELECT passenger_count, trip_distance, cast(PULocationID AS STRING), CAST(DOLocationID AS STRING),
CAST(payment_type AS STRING), fare_amount, tolls_amount, tip_amount
FROM `bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned` WHERE fare_amount != 0
);

-- CREATE MODEL WITH DEFAULT SETTING
CREATE OR REPLACE MODEL `bamboo-autumn-360913.nytaxi.tip_model`
OPTIONS
(model_type='linear_reg',
input_label_cols=['tip_amount'],
DATA_SPLIT_METHOD='AUTO_SPLIT') AS
SELECT
*
FROM
`bamboo-autumn-360913.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL;

-- CHECK FEATURES
SELECT * FROM ML.FEATURE_INFO(MODEL `bamboo-autumn-360913.nytaxi.tip_model`);

-- EVALUATE THE MODEL
SELECT
*
FROM
ML.EVALUATE(MODEL `bamboo-autumn-360913-ny.nytaxi.tip_model`,
(
SELECT
*
FROM
`bamboo-autumn-360913.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL
));