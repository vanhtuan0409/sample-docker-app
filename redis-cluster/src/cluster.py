from rediscluster import RedisCluster
import time

startup_nodes = [
    {"host": "127.0.0.1", "port": "6001"},
    {"host": "127.0.0.1", "port": "6002"},
    {"host": "127.0.0.1", "port": "6003"},
    {"host": "127.0.0.1", "port": "6004"},
    {"host": "127.0.0.1", "port": "6005"},
    {"host": "127.0.0.1", "port": "6006"},
]

rc = RedisCluster(startup_nodes=startup_nodes, decode_responses=True)
rc.set("foo", "bar")

while True:
    try:
        val = rc.get('foo')
        print(val)
    except Exception:
        print("Error")
    finally:
        time.sleep(0.5)
