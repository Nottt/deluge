# Base Image
FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

# ADD Install Script & libtorrent

ADD https://raw.githubusercontent.com/Nottt/docker-deluge-latest/master/files/install.sh /root/install.sh
ADD https://github.com/Nottt/easy-deluge/releases/download/1.1.5/libtorrent-1.1.5-1_amd64.deb /root/libtorrent.deb

# Install necessary stuff

RUN apt-get update && apt install -y \
libboost-system-dev \
libboost-python-dev \
libboost-chrono-dev \
libboost-random-dev \
libssl-dev \
unrar \
software-properties-common \
apt-utils

# Run install script

RUN /bin/bash -c 'chmod +x /root/install.sh && /root/install.sh'

EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
