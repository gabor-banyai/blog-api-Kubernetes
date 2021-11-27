## Deploy Instructions

Ensure that storage, helm3, registry, metallb and istio are enabled in microk8s.

Create the TLS secret:
`kubectl create -n istio-system secret tls istio-ingressgateway-certs --key tls/tls.key --cert tls/tls.crt`

Copy the certification to the right folders:
```
sudo mkdir -p /etc/istio/ingressgateway-certs
sudo cp tls/tls.key /etc/istio/ingressgateway-certs
sudo cp tls/tls.crt /etc/istio/ingressgateway-certs
```

Add the three images to the repository:

```
sudo docker build -t localhost:32000/blog-ui:v1 blog-ui/ && sudo docker push localhost:32000/blog-ui:v1
sudo docker build -t localhost:32000/flask-api:v1 flask-api/ && sudo docker push localhost:32000/flask-api:v1
sudo docker build -t localhost:32000/init-database:v1 -f ./flask-api/DockerfileDataBase flask-api/ && sudo docker push localhost:32000/init-database:v1
```

Run `microk8s helm3 install blog-ui-chart blog-ui-chart`.

Run `kubectl get svc istio-ingressgateway -n istio-system`. The external IP shown here is used to access the website.

Get to the website with `http://<ip>:443`.

## Scaling Instructions
The application can be scaled horizontally by executing `kubectl scale --replicas=<n> deployment <deployment>` where `n` is the desired number and `deployment` is one of `blog-api-chart-deployment` and `blog-ui-chart-deployment`.

## Uninstall Instructions
The application can be uninstalled by executing `microk8s helm3 delete blog-ui-chart`.
To finish the cleanup, delete the certification secret and remove the tls folder:
```
kubectl delete secret -n istio-system istio-ingressgateway-certs
sudo rm -rf /etc/istio/ingressgateway-certs
```

## Upgrade Instructions
Execute a canary deployment by adding a canary development to the chart and then executing `microk8s helm3 upgrade blog-ui-chart blog-ui-chart`. This includes adding a canaryVersion and a canaryReplicaCount to values.yaml and updating the Version of the chart.

Execute a deployment rollout by upgrading an image or updating a template, updating the AppVersion and Version in the relevant Chart.yaml file and then executing `microk8s helm3 upgrade blog-ui-chart blog-ui-chart`.
