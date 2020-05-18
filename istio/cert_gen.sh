dns=$1

# Generate key and CRS
openssl req -newkey rsa:2048 -nodes -keyout resources/$dns.key -out resources/$dns.csr -subj "/CN=$dns"

# Generate self-signed cert
openssl x509 -req -days 365 -in resources/$dns.csr -signkey resources/$dns.key -sha256 -out resources/$dns.crt
