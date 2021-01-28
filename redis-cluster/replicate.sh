# Setup master slave
redis-cli -p 6002 replicaof 127.0.0.1 6001
redis-cli -p 6004 replicaof 127.0.0.1 6003
