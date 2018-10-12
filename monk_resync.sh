#!/bin/bash

##
## Script sync wallet using current bootstrap
##

PARAM1=$*
PARAM1=${PARAM1,,} 

if [ -z "$PARAM1" ]; then
  echo "Need to specify node alias!"
  exit -1
fi

if [ ! -f ~/bin/monkeyd_$PARAM1.sh ]; then
    echo "Wallet $PARAM1 not found!"
	exit -1
fi

for FILE in ~/bin/monkeyd_$PARAM1.sh; do
  echo "****************************************************************************"
  COUNTER=1
  DATE=$(date '+%d.%m.%Y %H:%M:%S');
  echo "DATE="$DATE
  echo FILE: " $FILE"
  MONKSTARTPOS=$(echo $FILE | grep -b -o _)
  MONKLENGTH=$(echo $FILE | grep -b -o .sh)./mon
  # echo ${MONKSTARTPOS:0:2}
  MONKSTARTPOS_1=$(echo ${MONKSTARTPOS:0:2})
  MONKSTARTPOS_1=$[MONKSTARTPOS_1 + 1]
  MONKNAME=$(echo ${FILE:MONKSTARTPOS_1:${MONKLENGTH:0:2}-MONKSTARTPOS_1})
  MONKCONFPATH=$(echo "$HOME/.monkey_$MONKNAME")
  # echo $MONKSTARTPOS_1
  # echo ${MONKLENGTH:0:2}
  echo CONF DIR: $MONKCONFPATH
  
  if [ ! -d $MONKCONFPATH ]; then
	echo "Directory $MONKCONFPATH not found!"
	exit -1
  fi	   
  
  for (( ; ; ))
  do
    sleep 2
	
	MONKPID=`ps -ef | grep -i _$MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	echo "MONKPID="$MONKPID
	
	if [ -z "$MONKPID" ]; then
	  echo "Monk $MONKNAME is STOPPED can't check if synced!"
	fi
  
	LASTBLOCK=$(~/bin/monkey-cli_$MONKNAME.sh getblockcount)
	GETBLOCKHASH=$(~/bin/monkey-cli_$MONKNAME.sh getblockhash $LASTBLOCK)

	echo "LASTBLOCK="$LASTBLOCK
	echo "GETBLOCKHASH="$GETBLOCKHASH
	
	LASTBLOCKCOINEXPLORERMONK=$(curl -s4 https://www.coinexplorer.net/api/MONK/block/latest)
	# echo $LASTBLOCKCOINEXPLORERMONK
	BLOCKHASHCOINEXPLORERMONK=', ' read -r -a array <<< $LASTBLOCKCOINEXPLORERMONK
	BLOCKCOUNTCOINEXPLORERMONK=${array[8]}
	# echo $BLOCKCOUNTCOINEXPLORERMONK	
	BLOCKCOUNTCOINEXPLORERMONK=$(echo $BLOCKCOUNTCOINEXPLORERMONK | tr , " ")
	# echo $BLOCKCOUNTCOINEXPLORERMONK
	BLOCKCOUNTCOINEXPLORERMONK=$(echo $BLOCKCOUNTCOINEXPLORERMONK | tr '"' " ")
	# echo $BLOCKCOUNTCOINEXPLORERMONK
	# echo -e "BLOCKCOUNTCOINEXPLORERMONK='${BLOCKCOUNTCOINEXPLORERMONK}'"
	BLOCKCOUNTCOINEXPLORERMONK="$(echo -e "${BLOCKCOUNTCOINEXPLORERMONK}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "BLOCKCOUNTCOINEXPLORERMONK='${BLOCKCOUNTCOINEXPLORERMONK}'"	
	
	BLOCKHASHCOINEXPLORERMONK=${array[6]}
	# echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK
	BLOCKHASHCOINEXPLORERMONK=$(echo $BLOCKHASHCOINEXPLORERMONK | tr , " ")
	# echo $BLOCKHASHCOINEXPLORERMONK
	BLOCKHASHCOINEXPLORERMONK=$(echo $BLOCKHASHCOINEXPLORERMONK | tr '"' " ")
	# echo $BLOCKHASHCOINEXPLORERMONK
	# echo -e "BLOCKHASHCOINEXPLORERMONK='${BLOCKHASHCOINEXPLORERMONK}'"
	BLOCKHASHCOINEXPLORERMONK="$(echo -e "${BLOCKHASHCOINEXPLORERMONK}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "BLOCKHASHCOINEXPLORERMONK='${BLOCKHASHCOINEXPLORERMONK}'"		

	echo "LASTBLOCK="$LASTBLOCK
	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK


	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK

	if [ "$BLOCKHASHCOINEXPLORERMONK" == "Too" ]; then
	   echo "COINEXPLORERMONK Too many requests"
	   break  
	fi
	
	# Wallet is not synced
	echo $DATE" Wallet $MONKNAME is NOT SYNCED!"
	#
	# echo $LASTBLOCKCOINEXPLORERMONK
	#break
	
	if [ -z "$MONKPID" ]; then
	   echo ""
	else
		#STOP 
		~/bin/monkey-cli_$MONKNAME.sh stop

		if [[ "$COUNTER" -gt 1 ]]; then
		  kill -9 $MONKPID
		fi
	fi
	
	sleep 3 # wait 3 seconds 
	MONKPID=`ps -ef | grep -i _$MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	echo "MONKPID="$MONKPID
	
	if [ -z "$MONKPID" ]; then
	  echo "Monk $MONKNAME is STOPPED"
	  
	  cd $MONKCONFPATH
	  echo CURRENT CONF FOLDER: $PWD
	  echo "Copy BLOCKCHAIN without conf files"
	  wget http://blockchain.monkey.vision/ -O bootstrap.zip
	  # rm -R peers.dat 
	  rm -R ./database
	  rm -R ./blocks	
	  rm -R ./sporks
	  rm -R ./chainstate		  
	  unzip  bootstrap.zip
	  $FILE
	  sleep 5 # wait 5 seconds 
	  
	  MONKPID=`ps -ef | grep -i _$MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	  echo "MONKPID="$MONKPID
	  
	  if [ -z "$MONKPID" ]; then
		echo "Monk $MONKNAME still not running!"
	  fi
	  
	  break
	else
	  echo "Monk $MONKNAME still running!"
	fi
	
	COUNTER=$[COUNTER + 1]
	echo COUNTER: $COUNTER
	if [[ "$COUNTER" -gt 9 ]]; then
	  break
	fi		
  done		
done