#/bin/bash

for FILE in ~/bin/monkeyd*.sh; do
  echo "****************************************************************************"
  COUNTER=1
  DATE=$(date '+%d:%m:%Y %H:%M:%S');
  echo "DATE="$DATE
  echo FILE: " $FILE"
  #cat $FILE
  MONKSTARTPOS=$(echo $FILE | grep -b -o _)
  MONKLENGTH=$(echo $FILE | grep -b -o .sh)
  # echo ${MONKSTARTPOS:0:2}
  MONKSTARTPOS_1=$(echo ${MONKSTARTPOS:0:2})
  MONKSTARTPOS_1=$[MONKSTARTPOS_1 + 1]
  MONKNAME=$(echo ${FILE:MONKSTARTPOS_1:${MONKLENGTH:0:2}-MONKSTARTPOS_1})
  MONKCONFPATH=$(echo "$HOME/.monkey_$MONKNAME")
  # echo $MONKSTARTPOS_1
  # echo ${MONKLENGTH:0:2}
  echo CONF FOLDER: $MONKCONFPATH
  
  for (( ; ; ))
  do
  
	MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	echo "MONKPID="$MONKPID
	
	if [ -z "$MONKPID" ]; then
	  echo "Monk $MONKNAME is STOPPED can't check if synced!"
	  break
	fi
  
	LASTBLOCK=$($FILE getblockcount)
	GETBLOCKHASH=$($FILE getblockhash $LASTBLOCK)
	GETBLOCKHASHEXPLORER=$(curl http://explorer.monkey.community/api/getblockhash?index=$LASTBLOCK)

	echo "LASTBLOCK="$LASTBLOCK
	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "GETBLOCKHASHEXPLORER="$GETBLOCKHASHEXPLORER

	if [ "$GETBLOCKHASH" == "$GETBLOCKHASHEXPLORER" ]; then
		echo "Wallet is SYNCED!"
		break
	else  
		# Wallet is not synced
		echo "Wallet is NOT SYNCED!"
		#
		#STOP 
		$FILE stop
		sleep 3 # wait 3 seconds 
		MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
		echo "MONKPID="$MONKPID
		
		if [ -z "$MONKPID" ]; then
		  echo "Monk $MONKNAME is STOPPED"
		  
		  cd $MONKCONFPATH
		  echo CURRENT CONF FOLDER: $PWD
		  echo "Copy BLOCKCHAIN without conf files"
		  wget http://blockchain.monkey.vision/ -O bootstrap.zip
		  rm -R peers.dat
		  rm -R ./database
		  rm -R ./blocks	  
		  unzip  bootstrap.zip
		  $FILE
		  sleep 5 # wait 5 seconds 
		  
		  MONKPID=`ps -ef | grep -i $MONKNAME | grep -i monkeyd | grep -v grep | awk '{print $2}'`
		  echo "MONKPID="$MONKPID
		  
		  if [ -z "$MONKPID" ]; then
			echo "Monk $MONKNAME still not running!"
		  fi
		  
		  break
		else
		  echo "Monk $MONKNAME still running!"
		fi
	fi
	
	COUNTER=$[COUNTER + 1]
	echo COUNTER: $COUNTER
	if [[ "$COUNTER" -gt 9 ]]; then
	  break
	fi		
  done		
done