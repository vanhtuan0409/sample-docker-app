# Istio

### Installation

```
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.4.3/charts/
kubectl create namespace istio-system
helm template istio.io/istio-init --namespace istio-system | kubectl apply -f -
kubectl -n istio-system wait --for=condition=complete job --all
helm template istio.io/istio --values values-istio-foody.yaml --namespace istio-system | kubectl apply -f -
```
