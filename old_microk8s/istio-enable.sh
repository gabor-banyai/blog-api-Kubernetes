microk8s enable metallb
microk8s enable istio
microk8s kubectl label namespace default istio-injection=enabled
