# Easy-deluge

A deluge docker container that is easy to use, with plugins and latest releases. 



*** IN DEVELOPMENT, DO NOT USE IT YET ***

docker run --rm \
           --name deluge \
           -p 8112:8112 \
           -p 58846:58846 \
           -p 49152:49152 \
           -e PUID=1010 \
           -e PGID=1010 \
           -v /etc/localtime:/etc/localtime:ro \
           -v /opt/deluge:/config \
           Nott/easy-deluge
