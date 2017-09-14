#!/usr/bin/env bash

# Command command line parameters
while [ "$1" != "" ]; do
    case $1 in
        -n | --service-name )   shift
                                SERVICE_NAME=$1
                                ;;
        -c | --chain-path )     shift
                                CHAIN_PATH=$1
                                ;;
        * )                    	return
    esac
    shift
done

mv ../authority_node/chain/keys/ethereum ../authority_node/chain/keys/Tobalaba
cp ./skel/authority.yml ../authority_node/docker-compose.yml
cp ./config/chain.json ../authority_node/config/chain.json
sudo systemctl restart ${SERVICE_NAME}
echo "$(date)" > ${CHAIN_PATH}/latest_update