#!/usr/bin/env bash

XPATH=$(pwd)

sudo apt-get -y remove docker docker-engine docker.io

sudo apt-get -y update

LINUX=$(uname -r)

sudo apt-get -y install \
    linux-image-extra-${LINUX} \
    linux-image-extra-virtual

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

RELEASE=$(lsb_release -cs)

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   ${RELEASE} \
   stable"

sudo apt-get update

sudo apt-get -y install docker-ce docker-compose

USER_NAME=$(whoami)

sudo adduser ${USER_NAME} docker

sudo systemctl enable docker

su ${USER_NAME}

cd ${XPATH}

/bin/bash ${XPATH}/ewf-create-authority.sh
