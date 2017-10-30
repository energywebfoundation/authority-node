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

# mv ../authority_node/chain/keys/ethereum ../authority_node/chain/keys/Tobalaba
# cp ./skel/authority.yml ../authority_node/docker-compose.yml
# cp ./config/chain.json ../authority_node/config/chain.json
# sudo systemctl restart ${SERVICE_NAME}
# sudo mkdir ../authority_node/chain/keys/Tobalaba/ 2>> /dev/null
# sudo cp ../authority_node/chain/keys/ethereum/UTC* ../authority_node/chain/keys/Tobalaba/ 2>> /dev/null
# cp ./config/enodeList.list ../authority_node/config/enodeList.list
# MINER=$(tail -n 1 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# sudo systemctl restart ewf-tobalaba-authority@ewf.service

# mkdir -v ../authority_node/monitor
# cp -v ./skel/eth-netstats.json ../authority_node/monitor/app.json
# cp -v ./skel/authority.yml ../authority_node/docker-compose.yml
sudo systemctl restart ewf-tobalaba-authority@ewf.service


echo "$(date)" > ../authority_node/latest_update
