#!/usr/bin/env bash
# when I was working hybrid remote+office, I used this script in cron to help
# me remember where I worked on a specific day, for tax and timesheet purposes.

#home network names:
homenets=("Blue" "Jet" "Jet-guest")
#office network names:
worknets=("OfficeNet" "OfficeNet2")
#file to log to:
filelog="$HOME/Documents/whereiworked.txt"
[ ! -e $filelog ] && touch $filelog

date=$(date +%Y-%m-%d\ %H:%M)

os=$(uname -a)
connectednet="dummyname"

if [[ "$os" =~ "Darwin" ]];then
	export connectednet=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}')
elif [[ "$os" =~ "Linux" ]];then
	export connectednet=$(nmcli -t connection show --active|grep "802-11"|cut -d ":" -f 1)
else
	echo "Not macos or Linux. Can't help you here!"
	exit 1
fi

success=0

#scan through home networks
for network in ${homenets[*]} ; do
    #echo "  testing network $network"
	[ "$network" = $(echo "$connectednet") ] && echo "$date home $connectednet" >> $filelog && export success=1
done

#scan through work networks
for network in ${worknets[*]} ; do
    #echo "  testing network $network"
	[ "$network" = $(echo "$connectednet") ] && echo "$date work $connectednet" >> $filelog && export success=1
done

#if there was no match in home or work networks
if [[ $success == 0 ]];then
	echo "$date unknown $connectednet" >> $filelog
fi
