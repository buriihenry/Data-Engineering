import os

from datetime import datetime

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator

AIRFLOW_HOME = os.environ.get("AIRFLOW_HOME", "/opt/airflow/")


local_workflow = DAG(
    "LocalIngestionDag",
    schedule_interval="0 6 2 * *",
    start_date=datetime(2021, 1, 1)
    
)

url= 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet'

with local_workflow:

    wget_task = BashOperator(
        task_id='wget',
        bash_command=f'curl -sSL {url} > {AIRFLOW_HOME}/output.parquet'
    )

    ingest_task = BashOperator(
        task_id='ingest',
        bash_command=f'ls {AIRFLOW_HOME}'
    )

    wget_task >> ingest_task