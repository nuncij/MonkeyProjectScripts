# MONKEY
Shell script to install a [MONKEY Masternode](https://www.monkey.vision/) on a Linux server running Ubuntu 16.04
**USE THIS AT YOUR OWN RISK**
***
## Installation:
Script monk.sh contains some useful tools to install, analize and repair your masternode from a command line menu.
```
wget https://raw.githubusercontent.com/CryptoCatOkiOKi/MonkeyProjectScripts/master/monk.sh -O monk.sh && chmod 755 monk.sh && ./monk.sh
```
***Steps:***
  1. Choose option 6. INSTALL NEW NODES (type 6, press ENTER).
  2. Do you want to install all needed dependencies (no if you did it before, yes if you are installing your first node)? [y/n]"
     * If it's your first time you host a MONKEY masternode on this Ubuntu Server, please type **y** 
     * If you installed a MONKEY masternode before on this server and only want to add a new one you can choose **n**.
  3. "How many nodes do you want to create on this server?, followed by [ENTER]:"
     * In our Tutorial we will choose 1 but you can put up to 8 on a 5$ Server and up to 15 on a 10$ Server of VULTR.   
  4. "Do you want wallets to restart on reboot? [y/n]"
     * If **y** then masternode will automatically start if server reboots,
     * If **n** then you will have to start your wallet manually if server restart
  5. "Enter alias for new node. Name must be unique! (Don't use same names as for previous nodes on old chain if you didn't delete old chain folders!)"
     * Enter name of your masternode (Name must be unique!) "e.g. MN1
  6. Now the script will:
     * Install wallet using bootstrap
     * Create CLI script for executing commands in command line (for example getinfo, masternode status so on…)
     * Generate masternode privatekey
     * Set port and RPC date (user, password, port,…)
     * Restart wallet   
  7. **At the end when you finish to setting your masternode (or more of them) you will see data that you have to put in your HOT WALLET masternode.conf**
     * copy / paste this line / lines in your notepad on your local machine
***

## Desktop wallet setup

After the MN is running and synced, you need to configure the desktop wallet accordingly. Here are the steps for QT Wallet
***Steps:***
1. Open the MONKEY Desktop Wallet.
2. Go to FILE -> Receiving Addresses
3. Create new Address, name it **MN1**
4. Send **2000** **MONKEY** to **MN1**.
5. Wait for 20 confirmations.
6. Go to **Tools -> "Debug console - Console"**
7. Type the following command: **masternode outputs**
8. Go to  ** Tools -> "Open Masternode Configuration File"
9. Copy / paste entries from your notepad (data from script outputs) and replace **txhash** and **outputidx** with values from your hot wallet using masternode outputs command in console (step 7)
* txhash: **First value from Step 7**
* outputidx:  **Second value from Step 7**
9. Save and close the file.
10. Restart Wallet and Make sure the wallet is unlocked.
11. Go to **Masternode Tab**. Click **Update status** to see your node.
12. Open **Debug Console** and type:
```
startmasternode alias false MN1
```
The following should appear:
```
“overall” : “Successfully started 1 masternodes, failed to start 0, total 1”,
“detail” : [
{
“alias” : “MN1”,
“result” : “successful”,
“error” : “”
}
```
*Note that Masternode will become **ENABLED** in Masternode tab but Active timer will remain 00:00 because its correct status is ACTIVE.*

### Check masternode status in hot wallet debug console:
Command:
```
masternode list-conf
```
Output:
```
 {
    "alias": "MN1",
    "address": "<IP>:<PORT>",
    "privateKey": "<MASTERNODE PRIVAREKEY>",
    "txHash": "<TXHAS>",
    "outputIndex": "0",
    "status": "ACTIVE"
  }
```
*In few hours Masternode will change to status **ENABLED** and Active timer will start counting*

### Check masternode status on server side
Command:
```
./bin/monkey-cli_mn1.sh startmasternode local false
```
– A message “masternode successfully started” should appear
***

## MONK.sh script:
Start: 	
```
wget https://raw.githubusercontent.com/MONKEYPROJECT/Guides/master/monk.sh -O monk.sh && chmod 755 monk.sh && ./monk.sh
```
 
Options:
1. LIST ALL NODES – show all nodes
2. CHECK NODES SYNC – check if wallets are SYNCED
3. RESYNC NODE THAT ARE OUT OF SYNC – check wallets and if finds any that is not synced (on wrong chain) will automatically resync it with newest bootstrap.
4. RESTART NODES – start wallets
5. STOP NODE – stop wallets
6. INSTALL NEW NODES – will install a new cold wallet or more of them
7. CHECK NODE STATUS – masternode status
8. RESYNC SPECIFIC NODE - resync node (useful if node is stopped)
9. CALCULATE FREE MEMORY AND CPU FOR NEW NODES - tells you how many nodes can be installed on server
10. MONKEY LOGO
11. EXIT

## Commands:
Start: 	
```
./bin/monkeyd_mn1.sh
```
Stop:	
```
./bin/monkey-cli_mn1.sh stop
```
Status:	
```
./bin/monkey-cli_mn1.sh masternode status
```
Debug:	
```
cat ~/.monkey_mn1/debug.log
```
