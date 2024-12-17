#!/bin/bash


if [ ! -f /home/$SEEDBOX_USER/.config/Jackett/ServerConfig.json ]; then
    mv /home/Jackett/ServerConfig.json /home/$SEEDBOX_USER/.config/Jackett/ServerConfig.json
fi

if [ ! -f /home/$SEEDBOX_USER/.config/Radarr/config.xml ]; then
    mv /home/Radarr/config.xml /home/$SEEDBOX_USER/.config/Radarr/config.xml
fi

if [ ! -f /home/$SEEDBOX_USER/.config/Sonarr/config.xml ]; then
    mv /home/Sonarr/config.xml /home/$SEEDBOX_USER/.config/Sonarr/config.xml
fi

# Start systemd
exec /lib/systemd/systemd