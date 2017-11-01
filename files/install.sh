#!/bin/bash
# To do list : Make this a docker container
## Install latest deluge & libtorrent and make it ready to go

# Compile 

dpkg -i /root/libtorrent.deb && apt-get install -f && ldconfig

# ADD Deluge PPA to keep always updated and install deluge

add-apt-repository ppa:deluge-team/ppa -y && apt-get update && apt-get install deluged deluge-web deluge-console -y









