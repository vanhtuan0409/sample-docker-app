install:
	kubectl apply -f ./setup
	helm template --release-name now -f traefik.values.yml traefik/traefik | kubectl apply -f -
	helm template --release-name now -f cert-manager.values.yml jetstack/cert-manager | kubectl apply -f -

uninstall:
	kubectl delete -f ./setup || true
	helm template --release-name now -f traefik.values.yml traefik/traefik | kubectl delete -f - || true
	helm template --release-name now -f cert-manager.values.yml jetstack/cert-manager | kubectl delete -f - || true
