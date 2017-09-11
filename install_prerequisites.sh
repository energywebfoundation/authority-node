#!/usr/bin/env bash
TRETA=$(whoami)

sudo apt-get -y remove docker docker-engine docker.io

sudo apt-get -y update

sudo apt-get -y install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/${TRETA}/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/${TRETA} \
   $(lsb_release -cs) \
   stable"

sudo apt-get -y update

sudo apt-get -y install docker-ce docker-compose

sudo adduser ${TRETA} docker

sudo systemctl enable docker

sudo passwd ${TRETA}

exec sudo su -l {TRETA}