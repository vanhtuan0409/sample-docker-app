# Clean old state
redis-cli -p 8001 sentinel remove mymaster__group1
redis-cli -p 8001 sentinel remove mymaster__group2

# Sentinel monitor
redis-cli -p 8001 sentinel monitor mymaster1 127.0.0.1 6001 1
redis-cli -p 8001 sentinel set mymaster1 down-after-milliseconds 500
redis-cli -p 8001 sentinel set mymaster1 failover-timeout 1000

redis-cli -p 8001 sentinel monitor mymaster2 127.0.0.1 6003 1
redis-cli -p 8001 sentinel set mymaster2 down-after-milliseconds 500
redis-cli -p 8001 sentinel set mymaster2 failover-timeout 1000
