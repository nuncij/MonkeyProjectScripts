#/bin/bash

# 1. CHECKS
## CHECK IF WALLET RUNNING
## CHECK IF  WALLET SYNCED
# 2. STOP WALLET
## CHECK IF STOPPED
# 3. COPY BLOCKCHAIN FILES TO TMP DIR (BLOCK, DATABASE, peer.dat)
# 4. ZIP FILES
# 5. RESTART WALLET
## CHECK IF WALLET IS RUNNING
# 6. DELETE TMP FILES
# 7. COPY ZIP TO PUBLIC FOLDER 
# 8. RESTART WALLET

DATE=$(date -u '+%d%m%Y%H%M%S');
DATE_FORMAT=$(date -u '+%d:%m:%Y %H:%M:%S')" UTC";
COUNTER=1

# LET'S MAKE SOME QUICK CHECKS IF WALLET IS RUNNING AND IF SYNCED
for (( ; ; ))
do 
	echo "DATE="$DATE_FORMAT
	LASTBLOCK=$(~/bin/monkey-cli_bootstrap.sh getblockcount)
	GETBLOCKHASH=$(~/bin/monkey-cli_bootstrap.sh getblockhash $LASTBLOCK)
	GETBLOCKHASHEXPLORER=$(curl -s4 http://explorer.monkey.community/api/getblockhash?index=$LASTBLOCK)
	
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

	# echo "LASTBLOCK="$LASTBLOCK
	# echo "GETBLOCKHASH="$GETBLOCKHASH
	# echo "GETBLOCKHASHEXPLORER="$GETBLOCKHASHEXPLORER
	# echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK
	
	# # MONK SEED 1 BLOCKCOUNT
	# BLOCKINFOMONKSEED_1=""
	# BLOCKINFOMONKSEED_1=$(curl -s4 http://nsseed1.monkey.vision/blockinfo.txt)	
	# # echo $BLOCKINFOMONKSEED_1
	# BLOCKCOUNTMONKSEED_1=', ' read -r -a array <<< $BLOCKINFOMONKSEED_1
	# BLOCKCOUNTMONKSEED_1=${array[18]}
	# # echo $BLOCKCOUNTMONKSEED_1
	# BLOCKCOUNTMONKSEED_1=$(echo $BLOCKCOUNTMONKSEED_1 | tr , " ")
	# BLOCKCOUNTMONKSEED_1="$(echo -e "${BLOCKCOUNTMONKSEED_1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# # echo -e "BLOCKCOUNTMONKSEED_1='${BLOCKCOUNTMONKSEED_1}'"

	# # MONK SEED 2 BLOCKCOUNT
	# BLOCKINFOMONKSEED_2=""
	# BLOCKINFOMONKSEED_2=$(curl -s4 http://nsseed2.monkey.vision/blockinfo.txt)	
	# # echo $BLOCKINFOMONKSEED_2
	# BLOCKCOUNTMONKSEED_2=', ' read -r -a array <<< $BLOCKINFOMONKSEED_2
	# BLOCKCOUNTMONKSEED_2=${array[18]}
	# # echo $BLOCKCOUNTMONKSEED_2
	# BLOCKCOUNTMONKSEED_2=$(echo $BLOCKCOUNTMONKSEED_2 | tr , " ")
	# BLOCKCOUNTMONKSEED_2="$(echo -e "${BLOCKCOUNTMONKSEED_2}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# # echo -e "BLOCKCOUNTMONKSEED_2='${BLOCKCOUNTMONKSEED_2}'"	
	
	# echo "*******************************************************"
	# echo **1. CHECKING SEED ONE AND SEED TWO**
	# echo "BLOCKCOUNTMONKSEED_1="$BLOCKCOUNTMONKSEED_1
	# echo "BLOCKCOUNTMONKSEED_2="$BLOCKCOUNTMONKSEED_2
	# # BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 + 1] # testing :)
	# if [ "$BLOCKCOUNTMONKSEED_1" == "$BLOCKCOUNTMONKSEED_2" ]; then
		# echo "SEED ONE AND SEED TWO = OK"
		# # REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO = OK;")
	# else
		# BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 + 1]
		# if [ "$BLOCKCOUNTMONKSEED_1" == "$BLOCKCOUNTMONKSEED_2" ]; then
			# echo "SEED ONE AND SEED TWO = OK"
			# # REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO = OK;")
			# BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 - 1]
		# else
			# BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 - 2]
			# if [ "$BLOCKCOUNTMONKSEED_1" == "$BLOCKCOUNTMONKSEED_2" ]; then
				# echo "SEED ONE AND SEED TWO = OK"
				# # REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO = OK;")		
				# BLOCKCOUNTMONKSEED_2=$[BLOCKCOUNTMONKSEED_2 + 1]
			# else
				# echo "SEED ONE AND SEED TWO NOT MATCH !!!"
				# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo "SEED ONE AND SEED TWO NOT MATCH !!!;")
			# fi
		# fi
	# fi		
	
	# echo "*******************************************************"
	# echo **2. CHECKING COINSEXPLOPER MONK AND SEED ONE**
	# echo "BLOCKCOUNTCOINEXPLORERMONK="$BLOCKCOUNTCOINEXPLORERMONK
	# echo "BLOCKCOUNTMONKSEED_1="$BLOCKCOUNTMONKSEED_1
	# # BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 + 2] # testing :)
	# if [ "$BLOCKCOUNTCOINEXPLORERMONK" == "$BLOCKCOUNTMONKSEED_1" ]; then
		# echo "MONK EXPLORER AND SEED ONE = OK"
		# # REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "MONK EXPLORER AND SEED ONE = OK;")
	# else
		# BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 + 1]
		# if [ "$BLOCKCOUNTCOINEXPLORERMONK" == "$BLOCKCOUNTMONKSEED_1" ]; then
			# echo "MONK EXPLORER AND SEED ONE = OK"
			# # REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "MONK EXPLORER AND SEED ONE = OK;")
			# BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 - 1]
		# else
			# BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 - 2]
			# if [ "$BLOCKCOUNTCOINEXPLORERMONK" == "$BLOCKCOUNTMONKSEED_1" ]; then
				# echo "MONK EXPLORER AND SEED ONE = OK"
				# # REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "MONK EXPLORER AND SEED ONE = OK;")
				# BLOCKCOUNTMONKSEED_1=$[BLOCKCOUNTMONKSEED_1 + 1]
			# else
				# echo "MONK EXPLORER AND SEED ONE NOT MATCH !!!"
				# REPORTMAILBLOCKCOUNT=$REPORTMAILBLOCKCOUNT$(echo " ")$(echo "COIN EXPLORER MONK AND SEED ONE NOT MATCH !!!;")
			# fi
		# fi	
	# fi
	# echo "*******************************************************"	
	
	# # REPORTMAILBLOCKCOUNT="test"
	# echo $REPORTMAILBLOCKCOUNT
	# if [ -z "$REPORTMAILBLOCKCOUNT" ]; then
	  # echo "REPORTMAILBLOCKCOUNT is empty"
	# else
	  # echo $REPORTMAILBLOCKCOUNT
	  # exit -1
	# fi	

	echo "GETBLOCKHASH="$GETBLOCKHASH
	echo "BLOCKHASHCOINEXPLORERMONK="$BLOCKHASHCOINEXPLORERMONK
	if [ "$GETBLOCKHASH" == "$BLOCKHASHCOINEXPLORERMONK" ]; then
		echo "Wallet is SYNCED!"
		break
	else
		if [ -z "$GETBLOCKHASH" ]; then
			MONKPID=`ps -ef | grep -i monkey_bootstrap | grep -i monkeyd | grep -v grep | awk '{print $2}'`
			echo "MONKPID="$MONKPID
			if [ -z "$MONKPID" ]; then
				echo "monkeyd is not running"
				~/bin/monkeyd_bootstrap.sh
				sleep 3 # wait 3 seconds
			else
				sleep 3 # wait 3 seconds
			fi
		else
			echo "Wallet is NOT SYNCED!!!"
		fi
	fi

	if [[ "$COUNTER" -gt 9 ]]; then
		exit -1
	fi

	COUNTER=$[COUNTER + 1]
	echo $COUNTER
done

for (( ; ; ))
do
	#STOP 
	~/bin/monkey-cli_bootstrap.sh stop
	sleep 3 # wait 3 seconds 
	MONKPID=`ps -ef | grep -i monkey_bootstrap | grep -i monkeyd | grep -v grep | awk '{print $2}'`
	echo "MONKPID="$MONKPID
	
	if [ -z "$MONKPID" ]; then
		echo "Monk is STOPPED"
		echo "Copy BLOCKCHAIN without conf files"
		
		#create TMP folder
		mkdir -p /root/MONK/BOOTSTRAP/${DATE}_bootstrap
		cp -rfv /root/.monkey_bootstrap/blocks /root/MONK/BOOTSTRAP/${DATE}_bootstrap
		# cp -rfv /root/.monkey_bootstrap/database /root/MONK/BOOTSTRAP/${DATE}_bootstrap
		# cp -rfv /root/.monkey_monk2test002/peers.dat /root/MONK/BOOTSTRAP/${DATE}_bootstrap

		#ZIP
		cd /root/MONK/BOOTSTRAP/${DATE}_bootstrap/
		zip -r ${DATE}_bootstrap.zip ./*
		mv ./${DATE}_bootstrap.zip /root/MONK/BOOTSTRAP/
		cp -rfv /root/MONK/BOOTSTRAP/${DATE}_bootstrap.zip /root/MONK/BOOTSTRAP/bootstrap_tmp.zip
		rm -R /root/MONK/BOOTSTRAP/${DATE}_bootstrap.zip
		cd
		
		# SEND BOOTSTRAP TO MONKEY FTP
		# scp <file to upload> <username>@<hostname>:<destination path>
		echo "FTP"
		FTPHOST=46.30.211.116
		FTPUSER=monkey.vision
		FTPPASSWORD='8Zz)CuG!<%f9J-n4xA'
		 
		cd /root/MONK/BOOTSTRAP/
		
		# create bootstrap txt
		rm bootstrap.txt
		echo "***LATEST MONK BOOTSTRAP STATUS***" > bootstrap.txt
		echo "##################################" >> bootstrap.txt
		echo "DATE "$DATE_FORMAT >> bootstrap.txt
		# echo "SEED 1 = "$BLOCKCOUNTMONKSEED_1 >> bootstrap.txt
		# echo "SEED 2 = "$BLOCKCOUNTMONKSEED_2 >> bootstrap.txt
		echo "BLOCKCOUNT = "$BLOCKCOUNTCOINEXPLORERMONK >> bootstrap.txt	

		ftp -inv $FTPHOST <<EOF
		user $FTPUSER $FTPPASSWORD
		cd /BOOTSTRAP
		mput bootstrap_tmp.zip
		mput bootstrap.txt
		rename bootstrap_tmp.zip bootstrap.zip
		bye
EOF
		
		cd

		# START
		~/bin/monkeyd_bootstrap.sh

		break

	else 
		echo "Monk is RUNNING"
		COUNTER=$[COUNTER + 1]
		echo $COUNTER
		if [[ "$COUNTER" -gt 9 ]]; then
			break
		fi
	fi
done

MONKPID2=`ps -ef | grep -i monkey_bootstrap | grep -i monkeyd | grep -v grep | awk '{print $2}'`

if [ -z "$MONKPID2" ]; then
	echo "Monk is STOPPED"
else 
	echo "Monk is RUNNING"
fi

rm -r /root/MONK/BOOTSTRAP/${DATE}_bootstrap
