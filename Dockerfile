# Base Image
FROM ubuntu

LABEL deluge

# Install necessary stuff to compile libtorrent and install deluge later

RUN apt-get update && apt-get install -y \
build-essential /
checkinstall /
libboost-system-dev /
libboost-python-dev /
libboost-chrono-dev /
libboost-random-dev /
libssl-dev /
curl /
wget /
software-properties-common /
python-software-properties /
unrar /
unzip  
&& rm -rf /var/lib/apt/lists/*

# Grab latest release of libtorrent and compile it

WORKDIR /root

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

ADD docker-deluge-latest/files/deluged.service /etc/systemd/system/deluged.service
ADD docker-deluge-latest/files/deluge-web.service /etc/systemd/system/deluge-web.service

RUN systemctl enable deluge-web.service \
&& systemctl enable deluged.service  \
&& cp /config/deluged/auth /config/deluge-web/auth \
&& systemctl start deluge-web.service \
&& systemctl start deluged.service






















EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
