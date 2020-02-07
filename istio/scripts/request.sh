host=${1}
count=${2:-100}
echo $host

for ((i=1;i<=100;i++)); do
  curl -s http://$host/hello
done
