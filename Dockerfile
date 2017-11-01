# Base Image
FROM ubuntu

# Install necessary stuff to compile libtorrent and install deluge later

RUN apt-get update && apt-get install -y \
## checkinstall \
build-essential \
libboost-system-dev \
libboost-python-dev \
libboost-chrono-dev \
libboost-random-dev \
libssl-dev \
curl \
wget \
software-properties-common \
python-software-properties \
unrar \
unzip 

# Grab latest release of libtorrent and compile it

ADD 

RUN curl -s https://api.github.com/repos/arvidn/libtorrent/releases/latest | grep "lib*.*gz" | cut -d : -f 2,3 | tr -d \" | wget -qi - \
tar xf *gz \
rm *gz \
cd lib* \
./configure --enable-debug=no --enable-python-binding --with-libiconv \
make \
make -j$(nproc) \
checkinstall \
ldconfig 

# Install deluge

RUN add-apt-repository ppa:deluge-team/ppa -y && apt-get update && apt-get install deluged deluge-web deluge-console -y

# Create directories and copy executables to /config

RUN mkdir -p /config/deluge /config/deluged /downloads && cp /usr/bin/deluged /config/deluged/ && cp /usr/bin/deluge-web /config/deluge-web

# Enable them 

COPY docker-deluge-latest/files/deluged.service /etc/systemd/system/deluged.service
























EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
