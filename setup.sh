#/bin/bash

cd ~
echo "******************************************************************************"
echo "* Ubuntu 16.04 is the recommended operating system for this install.         *"
echo "*                                                                            *"
echo "* This script will install and configure your MONK Coin masternodes(v2.3.0). *"
echo "******************************************************************************"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "This is the old script but is updated to install wallet version 2.3.0!"
echo "You can find the link for the new script on http://ubuntu.monkey.vision/"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""
read -n 1 -s -r -p "*****Press any key to continue or ctrl+c to cancel*****"
echo ""
echo "Do you want to install all needed dependencies (no if you did it before, yes if you are installing your first node)? [y/n]"
read DOSETUP

if [[ ${DOSETUP,,} =~ "y" ]] ; then
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nano htop git
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
  sudo apt-get install -y libboost-all-dev
  sudo apt-get install -y libevent-dev
  sudo apt-get install -y libminiupnpc-dev
  sudo apt-get install -y autoconf
  sudo apt-get install -y automake unzip
  sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
  sudo apt-get install -y dos2unix

  cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  sudo free
  sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
  cd

  ## COMPILE AND INSTALL
  mkdir -p ~/monkey_tmp
  cd ~/monkey_tmp
  
  # old verison v2.2.0
  # wget https://github.com/MONKEYPROJECT/MonkeyV2/releases/download/v2.2.0/monkey-2.2.0-x86_64-linux-gnu.tar.gz
  # tar -xvzf monkey-2.2.0-x86_64-linux-gnu.tar.gz
  # cd ./monkey-2.2.0/bin
  
  wget https://github.com/MONKEYPROJECT/MonkeyV2/releases/download/v2.3.0/monkey-2.3.0-x86_64-linux-gnu.tar.gz
  chmod 775 monkey-2.3.0-x86_64-linux-gnu.tar.gz
  tar -xvzf monkey-2.3.0-x86_64-linux-gnu.tar.gz
  cd ./monkey-2.3.0/bin
  
  sudo chmod 755 *
  sudo mv ./monkey* /usr/bin
  #read
  cd ~
  rm -rfd ~/monkey_tmp

  sudo apt-get install -y ufw
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw logging on
  echo "y" | sudo ufw enable
  sudo ufw status

  mkdir -p ~/bin
  echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
  source ~/.bashrc
fi

## Setup conf
mkdir -p ~/bin
IP=$(curl -s4 icanhazip.com)
NAME="monkey"

MNCOUNT=""
re='^[0-9]+$'
while ! [[ $MNCOUNT =~ $re ]] ; do
   echo ""
   echo "How many nodes do you want to create on this server?, followed by [ENTER]:"
   read MNCOUNT
done

for i in `seq 1 1 $MNCOUNT`; do
  echo ""
  echo "Enter alias for new node. Name must be unique! (Don't use same names as for previous nodes on old chain if you didn't delete old chain folders!)"
  read ALIAS  

  echo ""
  echo "Enter port for node $ALIAS (Any valid free port matching config from steps before: i.E. 37234)"
  read PORT

  echo ""
  echo "Enter RPC Port (Any valid free port: i.E. 9234)"
  read RPCPORT

  echo ""
  echo "Enter masternode private key for node $ALIAS"
  read PRIVKEY

  ALIAS=${ALIAS,,}
  CONF_DIR=~/.${NAME}_$ALIAS
  CONF_FILE=monkey.conf

  # Create scripts
  echo '#!/bin/bash' > ~/bin/${NAME}d_$ALIAS.sh
  echo "${NAME}d -daemon -conf=$CONF_DIR/${NAME}.conf -datadir=$CONF_DIR "'$*' >> ~/bin/${NAME}d_$ALIAS.sh
  echo "${NAME}-cli -conf=$CONF_DIR/${NAME}.conf -datadir=$CONF_DIR "'$*' > ~/bin/${NAME}-cli_$ALIAS.sh
  chmod 755 ~/bin/${NAME}*.sh

  mkdir -p $CONF_DIR
  echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> ${NAME}.conf_TEMP
  echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> ${NAME}.conf_TEMP
  echo "rpcallowip=127.0.0.1" >> ${NAME}.conf_TEMP
  echo "rpcport=$RPCPORT" >> ${NAME}.conf_TEMP
  echo "listen=1" >> ${NAME}.conf_TEMP
  echo "server=1" >> ${NAME}.conf_TEMP
  echo "daemon=1" >> ${NAME}.conf_TEMP
  echo "logtimestamps=1" >> ${NAME}.conf_TEMP
  echo "maxconnections=256" >> ${NAME}.conf_TEMP
  echo "masternode=1" >> ${NAME}.conf_TEMP

  echo "" >> ${NAME}.conf_TEMP
  echo "port=$PORT" >> ${NAME}.conf_TEMP
  # echo "masternodeaddr=$IP" >> ${NAME}.conf_TEMP
  echo "masternodeprivkey=$PRIVKEY" >> ${NAME}.conf_TEMP

  #old monk 
  #echo "" >> ${NAME}.conf_TEMP
  #echo "addnode=140.72.47.201" >> ${NAME}.conf_TEMP
  #echo "addnode=8.9.3.216" >> ${NAME}.conf_TEMP
  #echo "addnode=63.209.32.131" >> ${NAME}.conf_TEMP
  
  #echo "addnode=144.202.62.242" >> ${NAME}.conf_TEMP
  #echo "addnode=149.28.118.89" >> ${NAME}.conf_TEMP
  #echo "addnode=95.179.140.122" >> ${NAME}.conf_TEMP
  #echo "addnode=95.179.137.202" >> ${NAME}.conf_TEMP
  #echo "addnode=45.76.39.180" >> ${NAME}.conf_TEMP
  #echo "addnode=95.179.140.231" >> ${NAME}.conf_TEMP
  #echo "addnode=95.179.148.213" >> ${NAME}.conf_TEMP

  sudo ufw allow $PORT/tcp
  mv ${NAME}.conf_TEMP $CONF_DIR/monkey.conf

  sh ~/bin/${NAME}d_$ALIAS.sh
done
