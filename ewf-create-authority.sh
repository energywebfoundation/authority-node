#!/bin/bash
VERSION="0.69"
CHAIN_NAME="authority_node"
CHAIN_NODE=""
PARITY_RELEASE="nightly"
ETHSTATS=0

pwd=$(pwd)
eip=$(dig +short myip.opendns.com @resolver1.opendns.com)

RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RESET=`tput sgr0`


help()  { 
  echo "
  Usage: ewf-create-authority.sh OPTIONS
  OPTIONS:
    -c | --chain-node - Number of the authority chain node.
    -e | --ethstats - Enable ethstats monitoring of authority nodes. Default: Off
    -r | --release - Parity client version. Default: v1.7.0
    -n | --name name_of_the_node. Default: authority_node
  "
}

deploy() {
    echo "${GREEN}[.] Deploying \"$CHAIN_NAME\" node number $CHAIN_NODE"
    echo "${GREEN}[.] Crushing old chain${RESET}"
    rm -rfv $CHAIN_NAME
    echo "${GREEN}[.] Raising skeleton${RESET}"
    mkdir -v $CHAIN_NAME
    mkdir -v $CHAIN_NAME/chain
    mkdir -v $CHAIN_NAME/config
    cp -v ./config/* $CHAIN_NAME/config/
    cp -v ./skel/authority.yml $CHAIN_NAME/docker-compose.yml

    echo "${BLUE}
    *********************************************************************************
    *   IF ANY ERROR OCCUR AFTER ${RED}[!] ${BLUE}MARKS PLEASE REINSTALL DOCKER AND TRY         *
    *   RUNNING THIS SCRIPT AGAIN. THIS SCRIPT ASKS FOR TYPING A PASSWORD THAT      *
    *   IS NOT RECOVERABLE. IF THEY DON'T MATCH PLEASE RUN THIS SCRIPT AGAIN        *
    *********************************************************************************
    "
    echo "${RED}[!] Docker will download image.${RESET}"
    docker pull parity/parity:$PARITY_RELEASE

    echo "${RED}[!] Creating your Blockchain Account${RESET}"
    docker run -ti -v $pwd/$CHAIN_NAME/chain/:/root/.local/share/io.parity.ethereum/ parity/parity:$PARITY_RELEASE account new

    public_key=$(docker run -ti -v $pwd/$CHAIN_NAME/chain/:/root/.local/share/io.parity.ethereum/ parity/parity:$PARITY_RELEASE account list)

    echo "engine_signer = \"${public_key::42}\"" >> $CHAIN_NAME/config/authority.toml

    echo "
    CHAIN_NAME=$CHAIN_NAME
    CHAIN_NODE=$CHAIN_NODE
    PARITY_RELEASE=$PARITY_RELEASE" > $CHAIN_NAME/ewf-run.sh
    cat skel/init.sh >> $CHAIN_NAME/ewf-run.sh
    cat skel/pwd.sh >> $CHAIN_NAME/ewf-run.sh
    cat skel/run.sh >> $CHAIN_NAME/ewf-run.sh


    echo "${GREEN}[.] Magic done! Now please run:${RESET} 
    ${BLUE}cd $CHAIN_NAME
    source ewf-run.sh${RESET}"
}

# Read command line
while [ "$1" != "" ]; do
    case $1 in
        -n | --name )           shift
                                CHAIN_NAME=$1
                                ;;
        -c | --node )           shift
                                CHAIN_NODE=$1
                                ;;
	-r | --release)		    shift
                                PARITY_RELEASE=$1
                                ;;
	-e | --ethstats)	shift
				ETHSTATS=1
				;;
        -h | --help )           help
                                return
                                ;;
        * )                    	help
                                return
    esac
    shift
done

echo "${RED}
    *****************************************************************
    *   Energy Web Foundation Validator Node Deployer v.$VERSION        *
    *               http://energyweb.org/                           *
    *                                                               *
    *            Copyright © 2017 All rights reserved.              *
    *                                                               *
    *   ** This program requires Docker CE or EE installed. **      *
    *               https://www.docker.com/                         *
    *****************************************************************${RESET}
    "
    
deploy