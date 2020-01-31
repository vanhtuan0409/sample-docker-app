if=${IF:-enp0s31f6}
echo "Selecting interface $if"
ip="$(ip -4 a show $if | grep "inet" | awk '{print $2}' | cut -d/ -f1)"
echo "Local IP is $ip"
HOST_IP=$ip docker-compose up -d
