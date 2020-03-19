storage "mysql" {
  address = "mysql:3306"
  username = "vault"
  password = "password"
  database = "vault"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
}

telemetry {
  prometheus_retention_time = "60s"
  disable_hostname = true
}

ui = true
