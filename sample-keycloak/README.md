# Keycloak tutorial

### Bootstrap

Edit `start.sh` and replace connecting network interface. Then run

```sh
./start.sh
```

### Getting started

#### Prepare environment

- Set `/etc/hosts` with entry `127.0.0.1 keycloak.local.com`
- Modify docker-compose with appropriate DNS if does not use `keycloak.local.com`

#### Social login

- Adding 1 new Realm

- Adding Identity Provider (Google)

![idp1](resources/google_console.png)
![idp2](resources/keycloak_idp.png)

- Adding 1 new Client:
  - Each client represent an app that will integrate with Keycloak. For example: logs, k8s dashboard, moltres, .... So you need to create a difference client for each app

- Changing `Client/Access Type` to `confidential` then Save
  - `Credentials` tab will appear after saved

### Previous issues

#### Keycloak failed to connect MySQL

- Need to add environment `JDBC_PARAMS: "useSSL=false"`

#### Keycloak behind a proxy

- Need to add 2 environment variable:
  - `KEYCLOAK_FRONTEND_URL`: pointing to public entry of keycloak (in this case the public DNS/port of the proxy)
  - `PROXY_ADDRESS_FORWARDING`: need to be set to true
