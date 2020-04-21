#!/usr/bin/env bash

set -e # exit script immediately on first error
export DEBIAN_FRONTEND=noninteractive
DOCKER_VERSION="18.03.1~ce-0~debian"

apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    vim \
    ansible \
    git

echo "Installing docker via apt repo..."
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")  $(lsb_release -cs) stable"

apt-get update && apt install -y --no-install-recommends \
    docker-ce=#{DOCKER_VERSION}

echo "Adding vagrant user to docker and adm groups..."
groupadd docker &> /dev/null
usermod -aG docker vagrant
usermod -aG adm vagrant

echo "Writing docker aliases..."
cat > /etc/profile.d/00-aliases.sh <<EOF
alias d="docker"
EOF
echo "Enojy! :)"