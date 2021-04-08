#!/bin/bash

# Script tested on Debian 10 !!!

# Vars
USRNM="mladents"
# NAS=srbpc
# DRIVE=d

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

# CIFS add credentials. Fill/Edit username.password fields below
# cat << 'EOL' >> /etc/cifs-credentials
# username=$windows_user
# password=$windows_user_password
# EOL
# Mount data
# mount -t cifs vers=3.0 -o credentials=/etc/cifs-credentials //$NAS/$DRIVE /mnt/torrent_data
# echo "//$NAS/$DRIVE /mnt/torrent_data cifs credentials=/etc/cifs-credentials,vers=3.0,dir_mode=0777,file_mode=0777 0 0" >> /etc/fstab

# Add line to fstab for automount on startup. Destination is NAS (nfs).
# NOTE: I just had this issue with NFS mounts in fstab. It turned out that, on boot, the mounts were attempted when the network was not ready yet.
# Simply installing network-manager solved the issue!!!
cp /etc/fstab /etc/fstab.orig
echo "192.168.178.33:/volume1/data /mnt/torrent_data  nfs      defaults    0       0" >> /etc/fstab
mount -a
