from redis import Redis
import time

r = Redis(host='localhost', port=6379, db=0)

for i in range(1,1000):
    key = "foo{}".format(i)
    val = "bar{}".format(i)
    print("Set key: {}".format(i))
    r.set(key, val)

r.set('foo', 'bar')

while True:
    try:
        val = r.get('foo')
        print(val)
    except Exception:
        print("Error")
    finally:
        time.sleep(0.5)
