#!/usr/bin/env bash
USER_NAME=$(whoami)
LINUX=$(uname -r)
RELEASE=$(lsb_release -cs)

sudo apt-get -y remove docker docker-engine docker.io

sudo apt-get -y update

sudo apt-get -y install \
    linux-image-extra-${LINUX} \
    linux-image-extra-virtual

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   ${RELEASE} \
   stable"

sudo apt-get update

sudo apt-get -y install docker-ce docker-compose

sudo adduser ${USER_NAME} docker

sudo systemctl enable docker

exec sudo su -l ${USER_NAME}