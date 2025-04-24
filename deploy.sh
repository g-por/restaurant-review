#!/bin/bash

function load_image() {
  echo "Loading image to Minikube..."
  minikube image load restaurant-review-app:latest
}

function deploy_postgres() {
  echo "Deploying PostgreSQL..."
  kubectl apply -f k3s/postgres-pv.yaml
  kubectl apply -f k3s/postgres-pvc.yaml
  kubectl apply -f k3s/postgres-deployment.yaml
  kubectl apply -f k3s/postgres-service.yaml
}

function deploy_app() {
  echo "Deploying Spring Boot application..."
  kubectl apply -f k3s/app-deployment.yaml
  kubectl apply -f k3s/app-service.yaml
}

function deploy_log_reader() {
  echo "Starting log-reader..."
  kubectl apply -f k3s/log-reader.yaml
}

function show_url() {
  echo "Fetching application URL..."
  minikube service restaurant-app --url
}

function check_pods() {
  echo "Getting pod status..."
  kubectl get pods
}

function view_logs() {
  echo "Viewing log-reader output..."
  kubectl logs log-reader
}

function cleanup() {
  echo "Deleting all resources..."
  kubectl delete -f k3s/log-reader.yaml
  kubectl delete -f k3s/app-service.yaml
  kubectl delete -f k3s/app-deployment.yaml
  kubectl delete -f k3s/postgres-service.yaml
  kubectl delete -f k3s/postgres-deployment.yaml
  kubectl delete -f k3s/postgres-pvc.yaml
  kubectl delete -f k3s/postgres-pv.yaml
}

while true; do
  echo ""
  echo "│     Kubernetes Deploy Menu    │"
  echo "1. Load image"
  echo "2. Deploy PostgreSQL"
  echo "3. Deploy Spring Boot application"
  echo "4. Start log-reader"
  echo "5. Show application URL"
  echo "6. Check pod status"
  echo "7. View log-reader logs"
  echo "8. Delete all resources"
  echo "9. Exit"
  echo -n "Select an option (1-9): "
  read choice

  case $choice in
    1) load_image ;;
    2) deploy_postgres ;;
    3) deploy_app ;;
    4) deploy_log_reader ;;
    5) show_url ;;
    6) check_pods ;;
    7) view_logs ;;
    8) cleanup ;;
    9) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid option. Please try again." ;;
  esac
done