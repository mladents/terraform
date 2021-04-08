#!/bin/bash

# Vars
HOMEDIR="/home/User"


# Prepare ENV for docker

## Portainer
mkdir -p $HOMEDIR/configs/portainer
## OpenVPN
mkdir -p $HOMEDIR/configs/vpn
cd $HOMEDIR/configs/vpn
cat << 'EOL' >> vpn.conf
client
proto tcp
remote myRemoteVPN 1194 tcp
dev tun
nobind
persist-key
persist-tun
verb 3
cipher AES-256-CBC
auth SHA1
remote-cert-tls server
redirect-gateway def1
auth-user-pass auth.cfg
auth-nocache
tls-client

<ca>
-----BEGIN CERTIFICATE-----
MIIDHjCCAgagAwIBAgIIS1exH1i9Y9QwDQYJKoZIhvcNAQELBQAwGjELMAkGA1UE
-----END CERTIFICATE-----
</ca>

<cert>
-----BEGIN CERTIFICATE-----
MIIDJzCCAg+gAwIBAgIIZ/iYU39682QwDQYJKoZIhvcNAQELBQAwGjELMAkGA1UE
-----END CERTIFICATE-----
</cert>

<key>
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDuOr12Q8JRydhV
-----END PRIVATE KEY-----
</key>
EOL
cat << 'EOL' >> auth.cfg
pc1
MySecretPasswd
EOL

cd $HOMEDIR/

## Adguard
mkdir -p $HOMEDIR/configs/adguard/workdir
mkdir -p $HOMEDIR/configs/adguard/conf

## Jellyfin
mkdir -p $HOMEDIR/configs/jellyfin/config
mkdir -p $HOMEDIR/configs/jellyfin/cache
