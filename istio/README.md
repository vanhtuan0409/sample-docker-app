# Istio

### Installation

Istio 1.5 require [special flag](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#service-account-token-volume-projection) on Kube-apiserver. In order to run Istio 1.5 on Minikube, you must run as follow

```
minikube start --extra-config=apiserver.service-account-signing-key-file=/var/lib/minikube/certs/sa.key --extra-config=apiserver.service-account-issuer=kubernetes/serviceaccount --extra-config=apiserver.service-account-api-audiences=api
```

Istio come with a special [IstioOperator API](https://istio.io/docs/setup/install/istioctl/#customizing-the-configuration), better start with a minimal profile and adding up feature later. To install Istio

```
istioctl manifest generate -f istio.yml | kubectl apply -f -
```
