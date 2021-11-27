# !/bin/bash

# Delete the blogdb deployments and services and such
echo "Creating the blogdb stuff ..."
microk8s kubectl apply -f blogdb-storage.yaml
microk8s kubectl apply -f blogdb-secret.yaml
microk8s kubectl apply -f blogdb-config.yaml
microk8s kubectl apply -f blogdb-deployment.yaml
microk8s kubectl apply -f blogdb-service.yaml

# Delete flask-api stuff
echo "Creating the flask-api stuff ..."
microk8s kubectl apply -f flask-api-deployment.yaml
microk8s kubectl apply -f flask-api-service.yaml

# Delete blog-ui stuff
echo "Creating the blog-ui stuff ..."
microk8s kubectl apply -f blog-ui-deployment.yaml
microk8s kubectl apply -f blog-ui-service.yaml
microk8s kubectl apply -f blog-ui-ingress.yaml
