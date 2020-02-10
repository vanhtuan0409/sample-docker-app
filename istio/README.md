# Istio

### Installation

```
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.4.3/charts/
kubectl create namespace istio-system
helm template istio.io/istio-init --namespace istio-system | kubectl apply -f -
kubectl -n istio-system wait --for=condition=complete job --all
helm template istio.io/istio --values values-istio-foody.yaml --namespace istio-system | kubectl apply -f -
```

### Routing

- Gateway: Equals to Listener. Declare a protocol/port that Gateway should listen to
- VirtualService: Represent a service. Service might be
- DestinationRule: Represent a list of traffic control, shapping, management rules apply for a destination

```
Client --> Gateway --> VirtualService --> (DestinationRule) --> Destination
```

- For example `routing.yaml`:
  - K8s setup: 2 deployment `helloworld-v1` and `helloworld-v2`. 1 service `helloworld` for routing traffic to both deployment
  - Istio Gateway for listening on port 80
  - Istio VirtualService for represent `helloworld` and will forward to `helloworld.default.svc.cluster.local`
  - Istio DestinationRule will declare 2 subset for v1 and v2. Which is applied on `helloworld.default.svc.cluster.local`

### TLS

- Enable ingress `SDS`
- Generate a certificate using `scripts/cert_gen.sh`
- Create K8s secret using `kubectl -n istio-system create secret tls helloworld-cert --cert <path> --key <path>`
  - Note: secret must be created within Namespace `istio-system`
- Editing `Gateway` to add TLS mode

### IP Restricting

- Rule/Handler/Instance that is created in 1 specific namespace will only affect Envoy proxy which is deployed into that namespace (For example: rules that are created in default ns will only affect envoy sidecar on the default ns. Rules created in istio-system may affect Envoy Ingressgateway)
- For Ip whitelisting/blacklisting, we need an envoy sidecar deployed on each app. Ingress only block Global level traffic, no method for configration service specific level
