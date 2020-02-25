import libmc

mc = libmc.Client(['127.0.0.1:7900'])
res = mc.set("foo", "bar")
print(res)
value = mc.get("foo")
print(value)
