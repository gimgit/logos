#!/bin/bash

# Airflow 네임스페이스 생성
echo "Airflow 네임스페이스를 생성합니다."
kubectl apply -f namespace.yaml

# PostgreSQL 배포
echo "PostgreSQL을 배포합니다."
kubectl apply -f postgres-deployment.yaml

# Redis 배포
echo "Redis를 배포합니다."
kubectl apply -f redis-deployment.yaml

# Airflow ConfigMap 배포
echo "Airflow ConfigMap을 배포합니다."
kubectl apply -f airflow-configmap.yaml

# Airflow Webserver 배포
echo "Airflow Webserver를 배포합니다."
kubectl apply -f airflow-webserver-deployment.yaml

# Airflow Scheduler 배포
echo "Airflow Scheduler를 배포합니다."
kubectl apply -f airflow-scheduler-deployment.yaml

# Airflow Worker 배포
echo "Airflow Worker를 배포합니다."
kubectl apply -f airflow-worker-deployment.yaml

# Airflow 웹 UI 포트 포워딩
echo "Airflow 웹 UI 포트 포워딩을 설정합니다."
kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow
