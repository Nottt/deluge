#!/bin/bash
# To do list : Make this a docker container
## Install latest deluge & libtorrent and make it ready to go

# Install necessary packages 

apt-get update  && apt install build-essential checkinstall libboost-system-dev libboost-python-dev libboost-chrono-dev libboost-random-dev libssl-dev curl wget  -y

# Grab latest release of libtorrent and compile it 

# curl -s https://api.github.com/repos/arvidn/libtorrent/releases/latest | grep "lib*.*gz" | cut -d : -f 2,3 | tr -d \" | wget -qi -

# tar xf *gz && rm *gz && cd lib* && ./configure --enable-debug=no --enable-python-binding --with-libiconv && make && make -j$(nproc) && checkinstall && ldconfig

# ADD Deluge PPA to keep always updated and install deluge

add-apt-repository ppa:deluge-team/ppa -y && apt-get update && apt-get install deluged deluge-web deluge-console -y







