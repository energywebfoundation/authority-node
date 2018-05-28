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
# cp ./config/chain.json ../authority_node/config/chain.json
# sudo systemctl restart ewf-tobalaba-authority@ewf.service

# --- Hardfork 2 Wasm
# cp ./config/chain.json ../authority_node/config/chain.json
# sudo systemctl restart ewf-tobalaba-authority@ewf.service

# --- wasm docker
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# docker pull parity/parity:nightly
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- fixed old config toml
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# cp ./config/authority.toml ../authority_node/config/authority.toml
# sudo systemctl start ewf-tobalaba-authority@ewf.service

# --- tobalaba rescue attack machine
# if grep 'Eneco' ../authority_node/monitor/app.json
# then
#    echo "engine_signer = \"0xcff3cbbdb3c09e3e250ba6ce3e9ab4d147adc6fc\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'ENGIE Authority Node' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0xfF8d78d3dB79f46C018a3CCC04CaB24B4C263fe5\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'TWL' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0x6A2b1a140ad141Ef571E91D9Ed2B2fC6fA294317\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'Elia Group' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0xB5e8C1Bf705F10Bf4531941600F7D0a5bAb7f5E8\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'SP Group' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0xa0Fc126bF3423E36001a33395FF42c14F2017733\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'Centrica' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0xa3c898f7f02709ad8716a1d4d75fcd2647dfa97a\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'Shell' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0xB3E182cB4B4717c06991c39A59b21f002Cf0a61f\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'innogy authority node Tobalaba Net' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0x78d0558d9489e7f846a0cf9f40b1d917244615e2\"" >> ../authority_node/config/authority.toml
#fi
#if grep 'GridSingularity' ../authority_node/monitor/app.json
#then
#   echo "engine_signer = \"0x84318cAE5bF44f8EE9093980d77247cD30dEF2E3\"" >> ../authority_node/config/authority.toml
#fi
# if grep "Parity Technologies' Authority Node #0" ../authority_node/monitor/app.json
# then
#    echo "engine_signer = \"0x78d0558d9489e7f846a0cf9f40b1d917244615e2\"" >> ../authority_node/config/authority.toml
# fi

# --- wasm fork
# cp ./config/chain.json ../authority_node/config/chain.json
# sudo systemctl restart ewf-tobalaba-authority@ewf.service

# --- update to 1.12
# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# docker pull parity/parity:nightly
# sudo systemctl start ewf-tobalaba-authority@ewf.service

 if grep 'OLI' ../authority_node/monitor/app.json
 then
     sudo systemctl stop ewf-tobalaba-authority@ewf.service
     #docker pull parity/parity:stable
     rm -rf ../authority_node/chain/chains
     #cp ./skel/authority.yml ../authority_node/docker-compose.yml
     sudo systemctl start ewf-tobalaba-authority@ewf.service
fi

# sudo systemctl stop ewf-tobalaba-authority@ewf.service
# docker pull parity/parity:nightly
# sudo systemctl start ewf-tobalaba-authority@ewf.service

echo "$(date)" > ../authority_node/latest_update
