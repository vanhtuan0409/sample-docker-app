redis-cli -p 8001 sentinel remove mymaster1
redis-cli -p 8001 sentinel remove mymaster2
redis-cli -p 8001 sentinel remove mymaster__group1
redis-cli -p 8001 sentinel remove mymaster__group2

redis-cli -p 6001 flushall
redis-cli -p 6002 flushall
redis-cli -p 6003 flushall
redis-cli -p 6004 flushall
