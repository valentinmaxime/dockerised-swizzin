FROM debian:bullseye

ARG TERM
ARG SEEDBOX_USER
ARG SEEDBOX_PASS

ENV TERM=${TERM}
ENV SEEDBOX_USER=${SEEDBOX_USER}
ENV SEEDBOX_PASS=${SEEDBOX_PASS}

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    echo "Etc/UTC" > /etc/timezone

RUN apt-get update && \
    apt-get install -y \
    locales \
    systemd \
    systemd-sysv \
    sudo \
    git \
    curl \
    gnupg \
    software-properties-common \
    lsb-release \
    apt-transport-https \
    openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd

# Configure systemd
ENV container docker
STOPSIGNAL SIGRTMIN+3

# Expose necessary ports
EXPOSE 1-65535

# Incomplete folder for transmission
ENV incomplete_dir_enabled=true
ENV watch_dir_enabled=true

RUN curl -sL git.io/swizzin | bash -s -- --unattend nginx panel transmission radarr bazarr jackett --user $SEEDBOX_USER --pass $SEEDBOX_PASS

# Install sonarr without systemctl loop
RUN sed -i '/while ! curl/,/done/d' /etc/swizzin/scripts/install/sonarr.sh
RUN /etc/swizzin/scripts/box install sonarr

COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

RUN mkdir /home/Jackett/
RUN mkdir /home/Radarr/
RUN mkdir /home/Sonarr/
RUN mv /home/$SEEDBOX_USER/.config/Jackett/ServerConfig.json /home/Jackett/ServerConfig.json
RUN mv /home/$SEEDBOX_USER/.config/Radarr/config.xml /home/Radarr/config.xml
RUN mv /home/$SEEDBOX_USER/.config/Sonarr/config.xml /home/Sonarr/config.xml

CMD ["/usr/local/bin/startup.sh"]
