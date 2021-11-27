# !/bin/bash

# Delete the blogdb deployments and services and such
microk8s kubectl delete -f blogdb-deployment.yaml
microk8s kubectl delete -f blogdb-storage.yaml
microk8s kubectl delete -f blogdb-config.yaml
microk8s kubectl delete -f blogdb-secret.yaml
microk8s kubectl delete -f blogdb-service.yaml

# Delete flask-api stuff
microk8s kubectl delete -f flask-api-deployment.yaml
microk8s kubectl delete -f flask-api-service.yaml

# Delete blog-ui stuff
microk8s kubectl delete -f blog-ui-deployment.yaml
microk8s kubectl delete -f blog-ui-service.yaml
microk8s kubectl delete -f blog-ui-ingress.yaml
