FROM ceph/daemon:tag-build-master-kraken-ubuntu-16.04
RUN apt-get update && apt-get install -y -q net-tools iptables sharutils \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENTRYPOINT ["/entrypoint.sh"]
