#/bin/bash

## x. list all nodes -> monk_list.sh
## 1. check nodes sync -> monk_check_sync.sh
## 2. resync node out of sync -> monk_check_resync_all.sh
## x. restart node -> monk_restart.sh
## x. stop node -> monk_stop.sh
## 3. install new nodes -> monk_setupv2.sh
## 4. exit

RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
BROWN='\033[0;34m'
NC='\033[0m' # No Color


## Black        0;30     Dark Gray     1;30
## Red          0;31     Light Red     1;31
## Green        0;32     Light Green   1;32
## Brown/Orange 0;33     Yellow        1;33
## Blue         0;34     Light Blue    1;34
## Purple       0;35     Light Purple  1;35
## Cyan         0;36     Light Cyan    1;36
## Light Gray   0;37     White         1;37

echo && echo
echo "***************************************"
echo "***************MONK COIN***************"
echo "***************MAIN MENU***************"
echo ""
echo -e "${RED}1. list all nodes -> monk_list.sh" # OK
echo -e "2. check nodes sync -> monk_check_sync.sh" # OK
echo -e "3. resync node out of sync -> monk_check_resync_all.sh" # OK
echo -e "4. restart node -> monk_restart.sh" # OK
echo -e "5. stop node -> monk_stop.sh" # OK
echo -e "6. install new nodes -> monk_setupv2.sh" # OK
echo -e "7. check node status -> monk_check_status.sh" # OK
echo -e "8. exit${NC}" # OK
echo "---------------------------------------"
echo "choose an option:"
read OPTION
echo ${OPTION}
ALIAS=""

if [[ ${OPTION} == "1" ]] ; then
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_list.sh -O monk_list.sh > /dev/null 2>&1
  chmod 777 monk_list.sh
  /bin/bash ./monk_list.sh
elif [[ ${OPTION} == "2" ]] ; then
  echo "Which node do you want to check if synced? Enter alias (if empty then will check all)"
  read ALIAS
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_check_sync.sh -O monk_check_sync.sh > /dev/null 2>&1
  chmod 777 monk_check_sync.sh  
  /bin/bash ./monk_check_sync.sh $ALIAS
elif [[ ${OPTION} == "3" ]] ; then
  echo "Which node do you want to check sync and resync? Enter alias (if empty then will check all)"
  read ALIAS
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_check_resync_all.sh -O monk_check_resync_all.sh > /dev/null 2>&1
  chmod 777 monk_check_resync_all.sh  
  /bin/bash ./monk_check_resync_all.sh $ALIAS
elif [[ ${OPTION} == "4" ]] ; then
  echo "Which node do you want to restart? Enter alias (if empty then will check all)"
  read ALIAS
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_restart.sh -O monk_restart.sh > /dev/null 2>&1
  chmod 777 monk_restart.sh  
  /bin/bash ./monk_restart.sh $ALIAS
elif [[ ${OPTION} == "5" ]] ; then
  echo "Which node do you want to stop? Enter alias (if empty then will check all)"
  read ALIAS
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_stop.sh -O monk_stop.sh > /dev/null 2>&1
  chmod 777 monk_stop.sh  
  /bin/bash ./monk_stop.sh $ALIAS
elif [[ ${OPTION} == "6" ]] ; then
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_setupv2.sh -O monk_setupv2.sh > /dev/null 2>&1
  chmod 777 monk_setupv2.sh
  /bin/bash ./monk_setupv2.sh
elif [[ ${OPTION} == "7" ]] ; then
  echo "For which node do you want to check masternode status? Enter alias (if empty then will check all)"
  read ALIAS
  wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk_check_status.sh -O monk_check_status.sh > /dev/null 2>&1
  chmod 777 monk_check_status.sh  
  /bin/bash ./monk_check_status.sh $ALIAS  
elif [[ ${OPTION} == "8" ]] ; then
  exit 0
fi
/bin/bash ./monk.sh
