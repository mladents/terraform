#!/bin/bash

# Script tested on Debian 10 !!!

# Vars
USRNM="User"

# Repo update
apt-get update

# Install dependences...
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    nfs-common \
    network-manager \
    sudo \
    docker-compose \
    ffmpeg

# Add user to sudoers
/sbin/usermod -aG sudo $USRNM

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

/sbin/usermod -aG docker $USRNM

echo "Docker version"
docker version
echo "================"

# Make dir to mount data
mkdir -p /mnt/torrent_data
chmod 777 /mnt/torrent_data


# Add line to fstab for automount on startup. Destination is NAS (nfs).
# NOTE: I just had this issue with NFS mounts in fstab. It turned out that, on boot, the mounts were attempted when the network was not ready yet.
# Simply installing network-manager solved the issue!!!
cp /etc/fstab /etc/fstab.orig
echo "192.168.178.33:/volume1/data /mnt/torrent_data  nfs      defaults    0       0" >> /etc/fstab
mount -a
