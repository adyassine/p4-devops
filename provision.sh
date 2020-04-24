#!/usr/bin/env bash

set -e # exit script immediately on first error
export DEBIAN_FRONTEND=noninteractive

echo "Installing gitlab dependencies"
apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    python-pip

echo "Installing gitlab"
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
LC_ALL="en_US.UTF-8" LC_CTYPE="en_US.UTF-8" EXTERNAL_URL="http://192.168.33.20" apt-get install -y gitlab-ce
LC_ALL="en_US.UTF-8" LC_CTYPE="en_US.UTF-8" EXTERNAL_URL="http://192.168.33.20" gitlab-ctl reconfigure

echo "Installing docker dependencies"
apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")  $(lsb_release -cs) stable"
apt-get update && apt-get install -y --no-install-recommends docker-ce

docker run -d --name gitlab-runner --restart always \
 -v /srv/gitlab-runner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock \
 gitlab/gitlab-runner:latest

# manual config
#vagrant ssh
#sudo docker exec -it gitlab-runner gitlab-runner register
# URL : http://192.168.33.20
# Token :
# Desc : docker
# tag : docker
# Executor : docker
# Image : alpine:latest

echo "Installing pelican"
apt-get update && apt-get install -y --no-install-recommends python-pip python-setuptools

pip install pelican[Markdown]

echo "Writing aliases"
cat > /etc/profile.d/00-aliases.sh <<EOF
alias d="docker"
alias ll="ls -lash"
EOF
echo "Enojy !"

