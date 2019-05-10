# Deluge

A deluge docker container that is easy to use, with plugins and GTK access.

A docker template for *nix systems  :

```
docker create --rm \
           --name deluge \
           -p 8112:8112 \
           -p 58846:58846 \
           -p 50000:50000 \
           -e PUID=1010 \
           -e PGID=1010 \
           -v ~/downloads:/downloads \
           -v /etc/localtime:/etc/localtime:ro \
           -v /opt/deluge:/config \
           nottt/deluge
```
## Parameters

* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-v /opt/deluge:/config` - Directory where config files are stored
* `-v ~/downloads:/downloads` - Torrent download directory
* `-v /etc/localtime:/etc/localtime:ro` - Sync time with host
* `-p *:*` - Ports used, only change the left ports.

**When editing `-v` and `-p` paremeters, the host is always the left and the docker the right. Only change the left**

For shell access while the container is running do `docker exec -it deluge /bin/bash`.

## Setting up the application 

The admin interface is available at `http://<ip>:8112` with a default password of deluge.

To change the password (recommended) log in to the web interface and go to Preferences->Interface->Password.

The GTK UI interface is available at `<ip>:8112` with a default username of docker and retrieve your password with `docker exec -it deluge cat /config/deluged/auth`

By default completed downloads are moved to `/complete` and kept in `/incomplete` while downloading. There's also `/seed` if you only want to seed.

# Plugins : 

### Enabled by default with custom settings :

* **Label :**

Torrents sent with Sonarr/Radarr will automatically be moved to their relatives folder on completion (e.g /completed/radarr)

* **AutoADD :**

Torrents added to `/downloads/add` will be automatically added with no labels.
Torrents added to either `/music` or `/games` subfolders will be added with same label and moved to their relatives folder on completion.

* **SimpleExtractor :**

Files will be automatically extracted inside the folder they were downloaded. You don't need to do anything! The .rar/.zip files will be kept for seeding. 

### Available to be enabled :

* **DefaultTrackers** = Add trackers automatically to public trackers only

* **AutoRemovePlus** = For your most complex remove needs

* **Streaming** = Streaming is the new downloading right?

To configure those you'll have to use the GTK UI, but it's set and forget after that.

* **ltconfig** = Want extreming tuning and modification? Enjoy the latest libtorrent library and start tuning it with a click of a button.

* **LabelPlus** = For your most OCD labeling and organization needs

# To Do List

Push torrents to rutorrent for seeding

# How to contribute

1. Clone the branch with `git clone https://github.com/Nottt/deluge`
2. Go inside the created directory and build the new docker with `docker build -t deluge_dev .`
3. Run it with :
```
docker run --rm \
           --name deluge-dev \
           -p 7854:8112 \
           -p 60002:58846 \
           -p 60000:50000 \
           -e PUID=1000 \
           -e PGID=1000 \
           -v ~/deluge-dev/downloads:/downloads \
           -v /etc/localtime:/etc/localtime:ro \
           -v /opt/deluge-dev:/config \
           deluge_dev
```
4. Test your features
5. Pull 

OBS: Don't forget to change the ports, folders and --name and clean up the folders if you rebuild the docker after changing stuff

# Known Issues 

## Thin Client not loading the GUI for plugins

The thin client need the eggs locally in their plugin folder to render a GUI. This is usually `AppData\Roaming\deluge\plugins` on Windows. Download them from this github and put them in this folder before starting the thin client. 
