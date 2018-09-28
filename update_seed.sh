echo 
echo "MONK - Masternode updater"
echo ""
echo "Welcome to the MONK Masternode update script."
echo "Wallet v2.3.0"
echo

cd ~
sudo killall -9 monkeyd
sudo rm -rdf /usr/local/bin/monkey*
cd

mkdir -p MONKEY_TMP
cd MONKEY_TMP
wget https://github.com/MONKEYPROJECT/MonkeyV2/releases/download/v2.3.0/monkey-2.3.0-x86_64-linux-gnu.tar.gz
sudo chmod 775 monkey-2.3.0-x86_64-linux-gnu.tar.gz
tar -xvzf monkey-2.3.0-x86_64-linux-gnu.tar.gz

rm -f monkey-2.3.0-x86_64-linux-gnu.tar.gz
sudo chmod 775 ./monkey-2.3.0/bin/*
sudo mv ./monkey-2.3.0/bin/monkey* /usr/local/bin

cd ~
rm -rdf MONKEY_TMP

monkeyd -reindex

echo "Your masternode wallets are now updated!"
