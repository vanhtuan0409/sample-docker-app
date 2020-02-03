const Keycloak = require("keycloak-connect");
const express = require("express");
const session = require("express-session");

const memoryStore = new session.MemoryStore();
const keycloak = new Keycloak(
  {
    store: memoryStore
  },
  {
    realm: "Foody",
    "auth-server-url": "http://keycloak.local.com/auth",
    "ssl-required": "external",
    resource: "nodejs-app",
    credentials: {
      secret: "235033e8-7b62-48a9-a67f-aa736afa470d"
    },
    "confidential-port": 0
  }
);

const app = express();

app.use(
  session({
    secret: "my_cookie_secret",
    resave: false,
    saveUninitialized: true,
    store: memoryStore
  })
);
app.use(
  keycloak.middleware({
    logout: "/logout",
    admin: "/admin",
    protected: "/protected/resource"
  })
);

app.get("/", keycloak.protect(), (req, res) => {
  res.send("hello world!!!");
});

app.get("/login", keycloak.protect(), (req, res) => {
  res.json(JSON.parse(req.session["keycloak-token"]));
});

const port = process.env.HTTP_PORT || 3000;
const server = app.listen(port, () => {
  const host = server.address().address;
  console.log(`Application is running on http://${host}:${port}`);
});

