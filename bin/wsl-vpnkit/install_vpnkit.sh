#!/bin/bash

# install dependencies
sudo apt-get install iproute2 iptables iputils-ping dnsutils wget

# download wsl-vpnkit and unpack
VERSION=v0.4.x
wget https://github.com/sakai135/wsl-vpnkit/releases/download/$VERSION/wsl-vpnkit.tar.gz
tar --strip-components=1 -xf wsl-vpnkit.tar.gz \
    app/wsl-vpnkit \
    app/wsl-gvproxy.exe \
    app/wsl-vm \
    app/wsl-vpnkit.service
rm wsl-vpnkit.tar.gz
