#/bin/bash

##
##
##

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
echo "*******http://www.monkey.vision/*******"
echo ""
echo -e "${RED}1. LIST ALL NODES" # -> MONK_LIST.SH" # OK
echo -e "2. CHECK NODES SYNC" #  -> MONK_CHECK_SYNC.SH" # OK
echo -e "3. RESYNC NODES THAT ARE OUT OF SYNC" #  -> MONK_CHECK_RESYNC_ALL.SH" # OK
echo -e "4. RESTART NODES" #  -> MONK_RESTART.SH" # OK
echo -e "5. STOP NODES" #  -> MONK_STOP.SH" # OK
echo -e "6. INSTALL NEW NODES" #  -> MONK_SETUPV2.SH" # OK
echo -e "7. CHECK NODES STATUS" #  -> MONK_CHECK_STATUS.SH" # OK
echo -e "8. RESYNC SPECIFIC NODE (useful if node is stopped)" # -> monk_resync.sh # OK 
echo -e "${YELLOW}9. MONKEY LOGO${RED}" # MONKEY LOGO
echo -e "10. EXIT${NC}" # OK
echo "---------------------------------------"
echo "choose option number:"
read OPTION
# echo ${OPTION}
ALIAS=""

if [[ ${OPTION} == "1" ]] ; then
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_list.sh -O monk_list.sh > /dev/null 2>&1
  chmod 777 monk_list.sh
  dos2unix monk_list.sh > /dev/null 2>&1
  /bin/bash ./monk_list.sh
elif [[ ${OPTION} == "2" ]] ; then
  echo -e "${RED}Which node do you want to check if synced? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_check_sync.sh -O monk_check_sync.sh > /dev/null 2>&1
  chmod 777 monk_check_sync.sh  
  dos2unix monk_check_sync.sh > /dev/null 2>&1
  /bin/bash ./monk_check_sync.sh $ALIAS
elif [[ ${OPTION} == "3" ]] ; then
  echo -e "${RED}Which node do you want to check sync and resync? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_check_resync_all.sh -O monk_check_resync_all.sh > /dev/null 2>&1
  chmod 777 monk_check_resync_all.sh  
  dos2unix monk_check_resync_all.sh > /dev/null 2>&1
  /bin/bash ./monk_check_resync_all.sh $ALIAS
elif [[ ${OPTION} == "4" ]] ; then
  echo -e "${RED}Which node do you want to restart? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_restart.sh -O monk_restart.sh > /dev/null 2>&1
  chmod 777 monk_restart.sh  
  dos2unix monk_restart.sh > /dev/null 2>&1
  /bin/bash ./monk_restart.sh $ALIAS
elif [[ ${OPTION} == "5" ]] ; then
  echo -e "${RED}Which node do you want to stop? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_stop.sh -O monk_stop.sh > /dev/null 2>&1
  chmod 777 monk_stop.sh  
  dos2unix monk_stop.sh > /dev/null 2>&1
  /bin/bash ./monk_stop.sh $ALIAS
elif [[ ${OPTION} == "6" ]] ; then
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_setupv2.sh -O monk_setupv2.sh > /dev/null 2>&1
  chmod 777 monk_setupv2.sh
  dos2unix monk_setupv2.sh > /dev/null 2>&1
  /bin/bash ./monk_setupv2.sh
elif [[ ${OPTION} == "7" ]] ; then
  echo -e "${RED}For which node do you want to check masternode status? Enter alias (if empty then will check all)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_check_status.sh -O monk_check_status.sh > /dev/null 2>&1
  chmod 777 monk_check_status.sh  
  dos2unix monk_check_status.sh > /dev/null 2>&1
  /bin/bash ./monk_check_status.sh $ALIAS
elif [[ ${OPTION} == "8" ]] ; then  
  echo -e "${RED}For which node do you want to check masternode status? Enter alias (mandatory!)${NC}"
  read ALIAS
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk_resync.sh -O monk_resync.sh > /dev/null 2>&1
  chmod 777 monk_resync.sh
  dos2unix monk_resync.sh > /dev/null 2>&1
  /bin/bash ./monk_resync.sh $ALIAS
elif [[ ${OPTION} == "9" ]] ; then  
  wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monkey_logo.sh -O monkey_logo.sh > /dev/null 2>&1
  chmod 777 monkey_logo.sh
  dos2unix monkey_logo.sh > /dev/null 2>&1
  /bin/bash ./monkey_logo.sh
elif [[ ${OPTION} == "10" ]] ; then
  exit 0
fi
###
read -n 1 -s -r -p "****Press any key to go back to MONKEY MAIN MENU*****"
/bin/bash ./monk.sh