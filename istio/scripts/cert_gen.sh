# Generate a key and certificate signing request
openssl req -new -newkey rsa:2048 -nodes -keyout ../resources/certs/server.key -out ../resources/certs/server.csr

# Generate a self-signed cert
openssl x509 -req -days 365 -in ../resources/certs/server.csr -signkey ../resources/certs/server.key -sha256 -out server.crt
