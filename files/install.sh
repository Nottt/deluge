#!/bin/bash
# To do list : Make this a docker container
## Install latest deluge & libtorrent and make it ready to go

# Compile 

dpkg -i /root/libtorrent.deb && apt-get install -f && ldconfig

# ADD Deluge PPA to keep always updated and install deluge

add-apt-repository ppa:deluge-team/ppa -y && apt-get update && apt-get install deluged deluge-web deluge-console -y

# Create necessary folders 

mkdir -p /config/data /downloads/complete /downloads/add /downloads/incomplete /downloads/seed 

# Move necessary folders to /config

cp /usr/bin/deluge* /config 

# Create user and set permissions

adduser --disabled-login --no-create-home --gecos "" deluge




# install s6-overlay
    curl -s -o - -L "https://github.com/just-containers/s6-overlay/releases/download/v1.20.0.0/s6-overlay-amd64.tar.gz" | tar xzf - -C / && \







