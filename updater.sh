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

# --- ADDED NETSTATS

# mkdir -v ../authority_node/monitor
# cp -v ./skel/eth-netstats.json ../authority_node/monitor/app.json
# cp -v ./skel/authority.yml ../authority_node/docker-compose.yml

# --- FORK 1

# MINER=$(tail -n 1 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# cp ./config/chain.json ../authority_node/config/chain.json
# rm -rf ../authority_node/chain/chains/Tobalaba
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# docker pull parity/parity:nightly
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Change gas price
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# MINER=$(tail -n 1 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Change gas limit to 2 bill
# MINER=$(tail -n 1 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Change gas back to 8 mill
# MINER=$(tail -c 61 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Migration to energyweb repository
# git remote rm origin
# git remote add origin http://github.com/energywebfoundation/authority-node.git
# git pull
# git branch --set-upstream-to=origin/master master
# git pull --no-edit

# --- Change gas settings
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# MINER=$(tail -n 1 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# cp ./skel/authority.yml ../authority_node/docker-compose.yml
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Extend enode list
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# cp ./config/enodeList.list ../authority_node/config/enodeList.list
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Change gas settings
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# MINER=$(tail -n 1 ../authority_node/config/authority.toml)
# cp ./config/authority.toml ../authority_node/config/authority.toml
# echo "${MINER}" >> ../authority_node/config/authority.toml
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- Netstats restart
# sudo systemctl restart ewf-tobalaba-authority@ewf.service

# --- Change uncleBlockCount in chain file
cp ./config/chain.json ../authority_node/config/chain.json
sudo systemctl restart ewf-tobalaba-authority@ewf.service

echo "$(date)" > ../authority_node/latest_update
