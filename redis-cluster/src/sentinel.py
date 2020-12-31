from redis.sentinel import Sentinel
import time

sentinel = Sentinel([('localhost', 8001)], socket_timeout=0.1)

master = sentinel.master_for('mymaster', socket_timeout=0.1)

master.set('foo', 'bar')

while True:
    try:
        val = master.get('foo')
        print(val)
    except Exception:
        print("Error")
    finally:
        time.sleep(0.5)
