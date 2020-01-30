# Keycloak tutorial

### Bootstrap

```sh
docker-compose up -d
```

### Getting started

- Adding 1 new Realm

- Adding Identity Provider (Google)

![idp1](resources/google_console.png)
![idp2](resources/keycloak_idp.png)

- Adding 1 new Client:
  - Each client represent an app that will integrate with Keycloak. For example: logs, k8s dashboard, moltres, .... So you need to create a difference client for each app

### Previous issues

#### Keycloak failed to connect MySQL

- Need to add environment `JDBC_PARAMS: "useSSL=false"`

#### Keycloak behind a proxy

- Need to add 2 environment variable:
- `KEYCLOAK_FRONTEND_URL`: pointing to public entry of keycloak (in this case the public DNS/port of the proxy)
  - `PROXY_ADDRESS_FORWARDING`: need to be set to true
