#!/usr/bin/env bash

# making it look cool
RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RESET=`tput sgr0`

print_banner() {
echo "${RED}
    *****************************************************************
    *   Energy Web Foundation Validator Node Deployer v.${VERSION}        *
    *               http://energyweb.org/                           *
    *                                                               *
    *            Copyright © 2017 All rights reserved.              *
    *                                                               *
    *   ** This program requires Docker CE or EE installed. **      *
    *               https://www.docker.com/                         *
    *****************************************************************${RESET}
    "
}

print_banner
echo "${GREEN}[.] This script is written for ${RED}DEBIAN${RESET} and ${RED}UBUNTU${RESET} systems to install docker-ce and docker-compose and it's dependencies.${RESET}"

sudo apt-get -y remove docker docker-engine docker.io

sudo apt-get -y update

LINUX=$(uname -r)

sudo apt-get -y install \
    linux-image-extra-${LINUX} \
    linux-image-extra-virtual

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl

sudo apt-get install -y dnsutils
sudo apt-get -y install gnupg2
sudo apt-get -y install python-software-properties
sudo apt-get -y install software-properties-common

OS_NAME=$(. /etc/os-release; echo "$ID")
RELEASE=$(lsb_release -cs)

if [OS_NAME= "raspbian"]; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    echo "deb [arch=armhf] https://download.docker.com/linux/${OS_NAME} \
    ${RELEASE} stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
else
    curl -fsSL https://download.docker.com/linux/${OS_NAME}/gpg | sudo apt-key add -

    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/${OS_NAME} \
    ${RELEASE} \
    stable"
fi
sudo apt-get update

sudo apt-get -y install docker-ce docker-compose

USER_NAME=$(whoami)

sudo adduser ${USER_NAME} docker

sudo systemctl enable docker

echo "${RED}[!] ${BLUE}Please log out and in again as ${RED}${USER_NAME} ${BLUE} to refresh access to docker.${RESET}"
