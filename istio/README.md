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

*Notes:* default installation will create a auto-generated Gateway object. This should be replaced with your custom Gateway

### Gateway

Gateway CRD act as HTTP/TCP Listener to accept traffic, no routing logic is implemented

`spec.selector` section of Gateway is for select which Istio Ingress Deployment will host these listener. Usually this will match with your `istio-ingressgateway` labels. **Notes:** Gateway object and Istio Ingress Deployment must be in the same namespace

`spec.servers.hosts` is not actually for routing logic. It is an ACL control for select which **Virtual Server** is allowed to received traffic from this gateway. If no special requirements, can be set as `*`

```
kubectl apply -f manifests/gateway.yaml
```
