#!/usr/bin/env bash

set -e # exit script immediately on first error

# package version variables
dockerce_version="18.03.1~ce-0~debian"
dockercompose_version="1.25.5"

# script
echo -e "\e[34m\e[1m=== Update current packages ==="
apt-get update

echo -e "\e[34m\e[1m=== Neovim ($neovim_version) installation ==="
apt-get install -y neovim

echo -e "\e[34m\e[1m=== Ansible ($ansible_version) installation ==="
apt-get install -y ansible

echo -e "\e[34m\e[1m=== Docker CE ($dockerce_version) installation ==="
apt-get install -y apt-get-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg --output docker_gpg
apt-get-key add docker_gpg && rm -f docker_gpg
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce=$dockerce_version

echo -e "\e[34m\e[1m=== Docker-compose ($dockercompose_version) installation ==="
curl -L "https://github.com/docker/compose/releases/download/$dockercompose_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo -e "\e[34m\e[1m=== Check if Neovim, Ansible, Docker CE and Docker-compose are present ==="
dpkg-query -l neovim ansible docker-ce
docker-compose --version
