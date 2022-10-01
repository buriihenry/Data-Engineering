-- SELECT THE COLUMNS INTERESTED FOR YOU
SELECT passenger_count, trip_distance, PULocationID, DOLocationID, payment_type, fare_amount, tolls_amount, tip_amount
FROM `bamboo-autumn-360913.nytaxi.yellow_tripdata_partitoned` WHERE fare_amount != 0;