echo 
echo "MONK - Masternode updater"
echo ""
echo "Welcome to the MONK Masternode update script."
echo "Wallet v2.3.0"
echo

for filename in ~/bin/monkey-cli*.sh; do
  sh $filename stop
  sleep 1
done

cd ~
sudo killall -9 monkeyd
sudo rm -rdf /usr/bin/monkey*
cd

mkdir -p MONKEY_TMP
cd MONKEY_TMP
wget https://github.com/MONKEYPROJECT/MonkeyV2/releases/download/v2.3.0/monkey-2.3.0-x86_64-linux-gnu.tar.gz
sudo chmod 775 monkey-2.3.0-x86_64-linux-gnu.tar.gz
tar -xvzf monkey-2.3.0-x86_64-linux-gnu.tar.gz

rm -f monkey-2.3.0-x86_64-linux-gnu.tar.gz
sudo chmod 775 ./monkey-2.3.0/bin/*
sudo mv ./monkey-2.3.0/bin/monkey* /usr/bin

cd ~
rm -rdf MONKEY_TMP

for filename in ~/bin/monkeyd*.sh; do
  echo $filename
  sh $filename
  sleep 1
done

echo "Your masternode wallets are now updated!"
