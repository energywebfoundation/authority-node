#!/usr/bin/env bash
HISTFILE=~/.bash_history
set -o history

#remove old logfile
sudo rm ./log.txt 2&> /dev/null

printf "\n-------------- Operation System Type output --------------\n" 2&>> log.txt
lsb_release -a >> log.txt

printf "\n-------------- Netstats output ---------------------------\n" 2&>> log.txt
netstat -tulpen >> log.txt

printf "\n-------------- Running Docker Container ------------------\n" 2&>> log.txt
docker ps >> log.txt

printf "\n-------------- Systemctl output --------------------------\n" 2&>> log.txt
sudo systemctl status ewf-tobalaba-* >> log.txt

printf "\n-------------- Last 50 commands --------------------------\n" 2&>> log.txt
history 50 >> log.txt

printf "\n-------------- Last 50 Systemlogs ------------------------\n" 2&>> log.txt
sudo cat /var/log/syslog | tail -50 >> log.txt