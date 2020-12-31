from redis import Redis
import time

r = Redis(host='localhost', port=6379, db=0)
r.set('foo', 'bar')

while True:
    try:
        val = r.get('foo')
        print(val)
    except Exception:
        print("Error")
    finally:
        time.sleep(0.5)
