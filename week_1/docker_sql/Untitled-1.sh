services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: airflow
    volumes:
      - postgres-db-volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "airflow"]
      interval: 5s
      retries: 5
    restart: always

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v /d/henry/data_engineering/data_talks_zoomcamp/week_1/docker_sql:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

#docker
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data/:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

#docker
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  --volume //d/henry/data_engineering/week_1_refresher/week_1/ny_taxi_postgres_data/:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

#docker
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  --volume //d/henry/data_engineering/data_talks_zoomcamp/week_1/docker_sql/ny_taxi_postgres_data/:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

  # Network
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v /d/henry/data_engineering/data_talks_zoomcamp/week_1/docker/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database1 \
  postgres:13    

#PgAdmin
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin-3 \
  dpage/pgadmin5

  export GOOGLE_APPLICATION_CREDENTIALS="/c/Users/Lenovo/Downloads/eloquent-theme-360913-895faec0a947.json"
