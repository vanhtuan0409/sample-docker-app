# Keycloak tutorial

### Bootstrap

Edit `start.sh` and replace connecting network interface. Then run

```sh
./start.sh
```

### Flow

![flow](resources/flow.png)

### Getting started

#### Prepare environment

- Set `/etc/hosts` with entry `127.0.0.1 keycloak.local.com`
  - Because keycloak gatekeeper need a public way to access keycloak.
- Modify docker-compose with appropriate DNS if does not use `keycloak.local.com`

#### Social login

- Adding 1 new Realm
  - Setting Realm frontend URL as `http://keycloak.local.com/auth`

![realm](resources/realm_config.png)

- Adding Identity Provider (Google)

![idp1](resources/google_console.png)
![idp2](resources/keycloak_idp.png)

- Adding 1 new Client:
  - Each client represent an app that will integrate with Keycloak. For example: logs, k8s dashboard, moltres, .... So you need to create a difference client for each app
  - You might set Client `Root URL` and `Base URL` as desire app (for example echo app). This might be used as redirect URL after login.

- Changing `Client/Access Type` to `confidential` then Save
  - `Credentials` tab will appear after saved
  - Take note of Client Id and Secret in Credentials tab

- Follow the example config of Keycloak Gatekeeper

### Previous issues

#### Keycloak failed to connect MySQL

- Need to add environment `JDBC_PARAMS: "useSSL=false"`

#### Keycloak behind a proxy

- Need to add 2 environment variable:
  - `KEYCLOAK_FRONTEND_URL`: pointing to public entry of keycloak (in this case the public DNS/port of the proxy)
  - `PROXY_ADDRESS_FORWARDING`: need to be set to true

#### Keycloak IdP no access token

- Because of invalid scopes setting on Keycloak Gatekeeper
