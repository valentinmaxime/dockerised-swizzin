FROM debian:bullseye

ENV TERM=xterm
ENV SEEDBOX_USER="seedbox"
ENV SEEDBOX_PASS="test_password"


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


RUN curl -sL git.io/swizzin | bash -s -- --unattend nginx panel transmission radarr lidarr --user $SEEDBOX_USER --pass $SEEDBOX_PASS

# Activer systemd comme PID 1
CMD ["/lib/systemd/systemd"]