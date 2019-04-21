#!/bin/bash

###### you must be logged in as a sudo user, not root #######
# This script will update your ZelNode daemon to the current release
# Version ZelNodeUpdate v2.0

#wallet information
COIN_NAME='zelcash'
ZIPTAR='unzip'
CONFIG_FILE='zelcash.conf'
PORT=16125
COIN_DAEMON='zelcashd'
COIN_CLI='zelcash-cli'
COIN_PATH='/usr/local/bin'
USERNAME=$(who -m | awk '{print $1;}')
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='033[1;31m'
NC='\033[0m'
STOP='\e[0m'
FETCHPARAMS='https://raw.githubusercontent.com/zelcash/zelcash/master/zcutil/fetch-params.sh'
#end of required details

#Display script name and version
clear
echo -e "${YELLOW}=================================================================="
echo -e "ZelNode Update, v2.0"
echo -e "==================================================================${NC}"
echo -e "${BLUE}17 April. 2019, by Alttank fam, dk808, Goose-Tech & Skyslayer${NC}"
echo -e
echo -e "${CYAN}ZelNode update starting, press [CTRL-C] to cancel.${NC}"
sleep 3
echo -e
#check for correct user
USERNAME=$(who -m | awk '{print $1;}')
echo -e "${CYAN}You are currently logged in as ${GREEN}$USERNAME${CYAN}.\n\n"
read -p 'Was this the username used to install the ZelNode? [Y/n] ' -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo ""
    echo -e "${YELLOW}Please log out and login with the username you created for your ZelNode.${NC}"
      exit 1
fi
#check for root and exit with notice if user is root
ISROOT=$(whoami | awk '{print $1;}')
if [ "$ISROOT" = "root" ]; then
    echo -e "${CYAN}You are currently logged in as ${RED}root${CYAN}, please log out and log back in with as your sudo user.${NC}"
    exit
fi
sleep 2

#Install Ubuntu updates
echo -e "${YELLOW}================================================================="
echo "Updating your OS..."
echo -e "=================================================================${NC}"

#Closing zelcash daemon
#echo -e "${YELLOW}Stopping & removing all old instances of $COIN_NAME and Downloading new wallet...${NC}"
sudo systemctl stop zelcash > /dev/null 2>&1 && sleep 3
sudo zelcash-cli stop > /dev/null 2>&1 && sleep 5
sudo killall $COIN_DAEMON > /dev/null 2>&1
#Removing old zelcash files
#sudo apt-get purge zelcash -y
echo -e "${YELLOW}Updating new wallet binaries...${NC}"
#Install zelcash files using APT
#adding ZelCash APT Repo
#if [ -f /etc/apt/sources.list.d/zelcash.list ]; then
    #echo -e "\033[1;36mExisting repo found, backing up to ~/zelcash.list.old ...\033[0m"
    #sudo mv /etc/apt/sources.list.d/zelcash.list ~/zelcash.list.old;
    #sudo rm -rf ~/zelcash.list.old
    #sleep 2
#fi
#echo 'deb https://apt.zel.cash/ all main' | sudo tee --append /etc/apt/sources.list.d/zelcash.list > /dev/null
#gpg --keyserver keyserver.ubuntu.com --recv 4B69CA27A986265D > /dev/null
#gpg --export 4B69CA27A986265D | sudo apt-key add -
#sudo apt-get update -y
#Installing ZelCash via APT if it is not installed already via APT or update if it is
#sudo apt-get install zelcash
sudo apt-get install --only-upgrade zelcash -y
sudo chmod 755 /usr/local/bin/zelcash*
#Install Ubuntu updates
echo -e "${YELLOW}======================================================="
echo "Updating your OS..."
echo -e "=======================================================${NC}"
echo -e "${GREEN}Installing package updates...${NC}"
#Update and upgrade packages
#sudo apt-get update -y
#sudo apt-get upgrade -y
echo -e "${GREEN}Linux Packages Updates complete...${NC}"
sleep 2
#Notice to user we are complete and request a reboot
echo -e "${GREEN}Update complete. Please reboot the VPS by typing: ${CYAN}sudo reboot -n"
echo -e "${GREEN}Then verify the ZelCash daemon has started by typing: ${CYAN}zelcash-cli getinfo${NC}"
