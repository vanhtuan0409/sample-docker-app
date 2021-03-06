from redis import Redis
import time
import sys

r = Redis(host='localhost', port=6379, db=0)

def gen_kv(i):
    return ("key:{}".format(i), "val:{}".format(i))

def read(N):
    for i in range(N):
        (key, expected_val) = gen_kv(i)
        try:
            val = r.get(key).decode('utf-8')
            if val == expected_val:
                print("Key is ok: {}".format(key))
            else:
                print("Key is not ok: {}. Expected {} got {}".format(key, expected_val, val))
        except Exception as e:
            print("Key is not OK: {}. ERR: {}".format(key, e))

def write(N):
    for i in range(N):
        (key, val) = gen_kv(i)
        try:
            r.set(key, val)
            print("Key is ok: {}".format(key))
        except Exception as e:
            print("Key is not OK: {}. ERR: {}".format(key, e))

def main():
    assert len(sys.argv) >= 2, "Missing command"
    command = sys.argv[1].lower()
    assert command == "read" or command == "write", "Invalid command \"{}\"".format(command)
    N = 200
    if command == "read":
        read(N)
    else:
        write(N)

if __name__ == "__main__":
    main()
