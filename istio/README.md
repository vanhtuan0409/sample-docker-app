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

### Virtual Service

Virtual Service is a routing unit for mapping http request to a target destination. When define a Virtual Service, you should specify explicitly which Gateway will host this Virtual Service

For detail on how matching configs are, please reference [official docs](https://istio.io/docs/reference/config/networking/virtual-service/#HTTPRoute)

*Notes:* Virtual Service aren't required to be in the same namespace with Gateway

### Destination and Destination Rules and ServiceEntry

Destination is **a network addressable service** for routing request to, lookup in Istio service registry. By default, Istio will import all platform's service registry (K8s service) into Istio own service registry
  - Istio service registry = platform's service registry (k8s service) + Istio ServiceEntry

Destination Rules is policies that apply **after the routing logic** has occured. These rules are mostly for connection pool and load balancing algorithm

### Authorization

Authorization is an ACL for accessing services. When define an Authorization, you must specific **selector** for select which Istio Ingress Deployment will be affected

The order of `ACTION` taken as follow:

```
1/ If there are any DENY policies that match the request, deny the request.
2/ If there are no ALLOW policies for the workload, allow the request.
3/ If any of the ALLOW policies match the request, allow the request.
4/ Deny the request.
```
