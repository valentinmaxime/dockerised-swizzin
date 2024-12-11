FROM ubuntu:20.04

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    echo "Etc/UTC" > /etc/timezone

# Met à jour les paquets et installe systemd, SSH, et autres outils nécessaires
RUN apt-get update && \
    apt-get install -y \
    locales \
    systemd \
    sudo \
    git \
    curl \
    gnupg \
    software-properties-common \
    lsb-release \
    apt-transport-https \
    openssh-server && \
    apt-get clean && \
    mkdir /var/run/sshd

# Configure systemd
ENV container docker
STOPSIGNAL SIGRTMIN+3

# Expose les ports nécessaires
EXPOSE 1-65535

COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Activer systemd comme PID 1
CMD ["/usr/local/bin/startup.sh"]