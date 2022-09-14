import os

from datetime import datetime

from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator


local_workflow = DAG(
    "LocalIngestionDag",
    
)

with local_workflow:

    wget_task = BashOperator(
        task_id='wget',
        bash_command='echo "hello-world"'
    )

    ingest_task = BashOperator(
        task_id='ingest',
        bash_command='echo "hello-world"'
    )

    wget_task >> ingest_task