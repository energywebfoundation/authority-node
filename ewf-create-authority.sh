#!/bin/bash
# release name
NAME="authority"
CHAIN_NAME="${NAME}_node"

# parity client conf
VERSION="0.69"
CHAIN_NODE="0"
PARITY_RELEASE="nightly"

# environmental-awareness
WORKING_DIR=$(pwd)
EXT_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
USER_NAME=$(whoami)

# auto start and daemon
SERVICE_NAME="ewf-${NAME}@${USER_NAME}.service"
SERVICE_EXEC="/bin/bash ${WORKING_DIR}/${NAME}/ewf-run.sh"

# making it look cool
RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RESET=`tput sgr0`


bane() {
    echo "${GREEN}[.] Crushing old chain${RESET}"
    rm -rfv ${CHAIN_NAME}

    echo "${GREEN}[.] Unregistered old daemon service${RESET}"
    sudo systemctl stop ${SERVICE_NAME}
    sudo systemctl disable ${SERVICE_NAME}
    sudo rm -fv /etc/systemd/system/${SERVICE_NAME}
    sudo systemctl daemon-reload
    sudo systemctl reset-failed
}

summon_undead() {
    echo "${GREEN}[.] Raising skeleton${RESET}"
    mkdir -v ${CHAIN_NAME}
    mkdir -v ${CHAIN_NAME}/config
    mkdir -v ${CHAIN_NAME}/chain
    mkdir -v ${CHAIN_NAME}/chain/keys
    mkdir -v ${CHAIN_NAME}/chain/keys/ethereum
    cp -v ./config/* ${CHAIN_NAME}/config/
    # Authority docker compose
    cp -v ./skel/authority.yml ${CHAIN_NAME}/docker-compose.yml
}

create_acc() {
    # Create new wallet key
    echo "${RED}[!] Creating your Wallet Account${RESET}"
    echo "${RED}[!] It is required to type it 3 times during this process${RESET}"
    docker run -ti -v ${WORKING_DIR}/${CHAIN_NAME}/chain/:/root/.local/share/io.parity.ethereum/ parity/parity:${PARITY_RELEASE} account new
}

create_pwd_file() {
    # Read Password
    echo "${GREEN}Type your Wallet password one more time:${RESET}"
    read -s password
    echo ${password} > ${CHAIN_NAME}/.secret
    echo ""
}

add_miner() {
    # Get signer key
    PK_SIG=$(docker run -ti -v ${WORKING_DIR}/${CHAIN_NAME}/chain/:/root/.local/share/io.parity.ethereum/ parity/parity:${PARITY_RELEASE} account list)
    # Add it to parity configuration
    echo "engine_signer = \"${PK_SIG::42}\"" >> ${CHAIN_NAME}/config/authority.toml
}

register_service() {

    echo "${GREEN}[.] Service register for ${SERVICE_NAME}${RESET}"
    echo "
[Unit]
Description=EWF ${NAME} Node
After=network.target

[Service]
Type=simple
User=%i
ExecStart=${SERVICE_EXEC}

[Install]
WantedBy=multi-user.target
" > ./${SERVICE_NAME}

    # Add file to daemon folder
    sudo mv ./${SERVICE_NAME} /etc/systemd/system/
    # Reload systemd to make the daemon aware of the new configuration
    sudo systemctl --system daemon-reload
    # Start automatically at boot, enable the service.
    sudo systemctl enable ${SERVICE_NAME}
    # Start service
    sudo systemctl start ${SERVICE_NAME}
}

deploy() {
    print_banner

    echo "${GREEN}[.] Deploying \"${CHAIN_NAME}\"${RED} AUTHORITY ${GREEN}node number ${CHAIN_NODE}"
    # Delete old folder and unregister service
    bane
    # Create base structure
    summon_undead

    # Docker
    print_warning
    echo "${RED}[!] Docker will download image.${RESET}"
    docker pull parity/parity:${PARITY_RELEASE}

    # Create Wallet account
    create_acc

    # Create file to enable autonomous service
    create_pwd_file

    # Create start script
    echo "
    CHAIN_NAME=${CHAIN_NAME}
    CHAIN_NODE=${CHAIN_NODE}
    PARITY_RELEASE=${PARITY_RELEASE}" > ${CHAIN_NAME}/ewf-run.sh
    cat skel/init.sh >> ${CHAIN_NAME}/ewf-run.sh
    cat skel/run.sh >> ${CHAIN_NAME}/ewf-run.sh

    # Minting Authority
    add_miner

    # Autostart Daemon
    register_service
    echo "${GREEN}[.] Magic done! The service is registered as ${BLUE}${SERVICE_NAME}${RESET}"
}

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

print_warning() {
    echo "${BLUE}
    *********************************************************************************
    *   IF ANY ERROR OCCUR AFTER ${RED}[!] ${BLUE}MARKS PLEASE REINSTALL DOCKER AND TRY         *
    *   RUNNING THIS SCRIPT AGAIN. THIS SCRIPT ASKS FOR TYPING A PASSWORD THAT      *
    *   IS NOT RECOVERABLE. IF THEY DON'T MATCH PLEASE RUN THIS SCRIPT AGAIN        *
    *********************************************************************************
    "
}

help()  {
  echo "
  Usage: ewf-create-${NAME}.sh OPTIONS
  OPTIONS:
    -c | --chain-node - Number of the authority chain node.
    -e | --ethstats - Enable ethstats monitoring of authority nodes. Default: Off
    -r | --release - Parity client version. Default: v1.7.0
    -n | --name name_of_the_node. Default: authority_node
  "
  return
}

# Command command line parameters
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

deploy