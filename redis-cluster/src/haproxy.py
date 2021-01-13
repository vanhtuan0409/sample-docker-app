from redis import Redis
import time

r = Redis(host='localhost', port=6379, db=0)

for i in range(1,1000):
    key = "foo{}".format(i)
    val = "bar{}".format(i)
    print("Set key: {}".format(i))
    r.set(key, val)

while True:
    for i in range(1,1000):
        key = "foo{}".format(i)
        expected_val = "bar{}".format(i)
        try:
            val = r.get(key).decode("utf-8")
            if val == expected_val:
                print("OK key {}".format(key))
            else:
                print("Not OK key {}".format(key))
        except Exception:
            print("Not OK key {}".format(key))
        finally:
            time.sleep(0.5)
