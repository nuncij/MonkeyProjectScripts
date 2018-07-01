#/bin/bash

echo CURRENT CONF FOLDER: $PWD
cd $PWD
echo "PLEASE QUIT YOUR MONK QT WALLETS BEFORE COUNTINUE!!!"
read -n 1 -s -r -p "Press any key to continue"

MONKPID=`ps -ef | grep -i Monkey-Qt | grep -v grep | awk '{print $2}'`

echo " "

if [ -z "$MONKPID" ]; then
	echo "Copy BLOCKCHAIN without conf files"
	wget http://blockchain.monkey.vision/ -O bootstrap.zip
	rm -R peers.dat
	rm -R ./database
	rm -R ./blocks	  
	unzip  bootstrap.zip
	
	if [ -e monkey.conf ]
	then
		echo "monkey.conf already exists!"
	else
		echo "monkey.conf don't exists!"
		echo "addnode=140.72.47.201" >> monkey.conf
		echo "addnode=8.9.3.216" >> monkey.conf
		echo "addnode=63.209.32.131" >> monkey.conf
	fi	
	
	if grep -Fxq "addnode=140.72.47.201" monkey.conf
	then
		# code if found
		echo "node already in monkey.conf"
	else
		# code if not found
		echo "addnode=140.72.47.201" >> monkey.conf
	fi
	
	if grep -Fxq "addnode=8.9.3.216" monkey.conf
	then
		# code if found
		echo "node already in monkey.conf"
	else
		# code if not found
		echo "addnode=8.9.3.216" >> monkey.conf
	fi

	if grep -Fxq "addnode=140.72.47.201" monkey.conf
	then
		# code if found
		echo "node already in monkey.conf"
	else
		# code if not found
		echo "addnode=63.209.32.131" >> monkey.conf
	fi	
else
	echo "QT Wallet still running!"
fi