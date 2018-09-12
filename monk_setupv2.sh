#/bin/bash

cd ~
echo "****************************************************************************"
echo "* Ubuntu 16.04 is the recommended operating system for this install.       *"
echo "*                                                                          *"
echo "* This script will install and configure your MONK Coin masternodes.       *"
echo "****************************************************************************"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo

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
  wget https://github.com/MONKEYPROJECT/MonkeyV2/releases/download/v2.2.0/monkey-2.2.0-x86_64-linux-gnu.tar.gz
  tar -xvzf monkey-2.2.0-x86_64-linux-gnu.tar.gz
  cd ./monkey-2.2.0/bin
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
rm ~/bin/masternode_config.txt &>/dev/null &
IP=$(curl -s4 icanhazip.com)
NAME="monkey"
COUNTER=1

MNCOUNT=""
REBOOTRESTART=""
re='^[0-9]+$'
while ! [[ $MNCOUNT =~ $re ]] ; do
   echo ""
   echo "How many nodes do you want to create on this server?, followed by [ENTER]:"
   read MNCOUNT
   echo "Do you want wallets to restart on reboot? [y/n]"
   read REBOOTRESTART
done

for i in `seq 1 1 $MNCOUNT`; do
  echo "************************************************************"
  echo ""
  echo "Enter alias for new node. Name must be unique! (Don't use same names as for previous nodes on old chain if you didn't delete old chain folders!)"
  read ALIAS 

  ALIAS=${ALIAS,,}  
  
  PORT=""
  RPCPORT=""
  echo ""
  # echo "Enter port for node $ALIAS (Any valid free port matching config from steps before: i.E. 37234)"
  # read PORT
  
  if [ -z "$PORT" ]; then
    PORT=37234
	RPCPORT=9234
	PORT1=""
    for (( ; ; ))
    do
	  PORT1=$(netstat -peanut | grep -i monkeyd | grep -i $PORT)

	  if [ -z "$PORT1" ]; then
		break
	  else
		PORT=$[PORT + 1]
		RPCPORT=$[RPCPORT + 1]
	  fi
    done  
  fi
  echo "PORT "$PORT

  if [ -z "$RPCPORT" ]; then
    echo ""
    echo "Enter RPC Port (Any valid free port: i.E. 9234)"
    read RPCPORT
  fi
  
  echo "RPCPORT "$RPCPORT

  PRIVKEY=""
  echo ""
  # echo "Enter masternode private key for node $ALIAS"
  # read PRIVKEY

  CONF_DIR=~/.${NAME}_$ALIAS
  CONF_FILE=monkey.conf
  
  if [[ "$COUNTER" -lt 2 ]]; then
    ALIASONE=$(echo $ALIAS)
  fi  
  echo "ALIASONE="$ALIASONE

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

  echo "" >> ${NAME}.conf_TEMP
  echo "port=$PORT" >> ${NAME}.conf_TEMP
  
  if [ -z "$PRIVKEY" ]; then
    echo ""
  else
    echo "masternode=1" >> ${NAME}.conf_TEMP
    echo "masternodeprivkey=$PRIVKEY" >> ${NAME}.conf_TEMP
  fi

  sudo ufw allow $PORT/tcp
  mv ${NAME}.conf_TEMP $CONF_DIR/monkey.conf
 
  if [ -z "$PRIVKEY" ]; then
	MONKPID=`ps -ef | grep -i $ALIASONE | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	
	if [ -z "$MONKPID" ]; then
      # start wallet
      sh ~/bin/${NAME}d_$ALIASONE.sh  
	  sleep 1
	fi
  
	for (( ; ; ))
	do  
	  echo "Please wait ..."
      sleep 3
	  PRIVKEY=$(~/bin/monkey-cli_${ALIASONE}.sh masternode genkey)
	  echo "PRIVKEY=$PRIVKEY"
	  if [ -z "$PRIVKEY" ]; then
	    echo "PRIVKEY is null"
	  else
	    break
      fi
	done
	
	sleep 1
	
	for (( ; ; ))
	do
		MONKPID=`ps -ef | grep -i $ALIAS | grep -i monkeyd | grep -v grep | awk '{print $2}'`
		if [ -z "$MONKPID" ]; then
		  echo ""
		else
		  #STOP 
		  ~/bin/monkey-cli_$ALIAS.sh stop
		fi
		echo "Please wait ..."
		sleep 3 # wait 3 seconds 
		MONKPID=`ps -ef | grep -i $ALIAS | grep -i monkeyd | grep -v grep | awk '{print $2}'`
		echo "MONKPID="$MONKPID	
		
		if [ -z "$MONKPID" ]; then
		  sleep 1 # wait 3 seconds 	
		  echo "masternode=1" >> $CONF_DIR/monkey.conf
		  echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/monkey.conf
		  # sh ~/bin/${NAME}d_$ALIAS.sh		
		  break
	    fi
	done
  fi
  
  sleep 2
  MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
  echo "MONKPID="$MONKPID
  
  if [ -z "$MONKPID" ]; then
     echo ""
  else
    ~/bin/monkey-cli_$ALIAS.sh stop
	sleep 3 # wait 3 seconds 
  fi	
  
  if [ -z "$MONKPID" ]; then
    cd $CONF_DIR
    echo "Copy BLOCKCHAIN without conf files"
    wget http://blockchain.monkey.vision/ -O bootstrap.zip
    # rm -R peers.dat 
	rm -R ./database
	rm -R ./blocks	
	rm -R ./sporks
	rm -R ./chainstate	
    unzip  bootstrap.zip
    sh ~/bin/${NAME}d_$ALIAS.sh		
    sleep 5 # wait 5 seconds 
  fi		  

  
  MNCONFIG=$(echo $ALIAS $IP:$PORT $PRIVKEY "txhash" "outputidx")
  echo $MNCONFIG >> ~/bin/masternode_config.txt
  
  if [[ ${REBOOTRESTART,,} =~ "y" ]] ; then
    (crontab -l 2>/dev/null; echo "@reboot sh ~/bin/${NAME}d_$ALIAS.sh") | crontab -
	(crontab -l 2>/dev/null; echo "@reboot sh /root/bin/${NAME}d_$ALIAS.sh") | crontab -
	sudo service cron reload
  fi
  
  COUNTER=$[COUNTER + 1]
done
echo ""
echo "****************************************************************"
echo "**Copy/Paste lines below in Hot wallet masternode.conf file**"
echo "**and replace txhash and outputidx with data from masternode outputs command**"
echo "**in hot wallet console**"
echo "**Tutorial: http://www.monkey.vision/ubuntu-masternodes/ **"
echo "****************************************************************"
cat ~/bin/masternode_config.txt
echo "****************************************************************"
echo ""