#!/bin/bash
 
echo "deb [trusted=yes arch=amd64] https://download.docker.com/linux/debian stretch stable" >> /etc/apt/sources.list
apt update
 
apt install -y
    libicu57 \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
apt install -y docker-ce docker-ce-cli containerd.io
 
 
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
