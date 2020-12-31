# Set 6002 as slave of 6001
# Sentinel do not set this for you
redis-cli -p 6002 replicaof 127.0.0.1 6001
