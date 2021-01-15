FROM envoyproxy/envoy:v1.17.0

RUN apt update && apt install -y python3

COPY ./opt /opt

ENTRYPOINT ["/opt/hot-restarter.py"]
CMD ["/usr/local/bin/envoy", "-c", "/etc/envoy/envoy.yaml"]
