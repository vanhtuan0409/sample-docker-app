# Setup master slave
redis-cli -p 6002 replicaof 127.0.0.1 6001
redis-cli -p 6004 replicaof 127.0.0.1 6003

# Sentinel monitor
redis-cli -p 8001 sentinel monitor mymaster__group1 127.0.0.1 6001 1
redis-cli -p 8001 sentinel set mymaster__group1 down-after-milliseconds 500
redis-cli -p 8001 sentinel set mymaster__group1 failover-timeout 500

redis-cli -p 8001 sentinel monitor mymaster__group2 127.0.0.1 6003 1
redis-cli -p 8001 sentinel set mymaster__group2 down-after-milliseconds 500
redis-cli -p 8001 sentinel set mymaster__group2 failover-timeout 500
