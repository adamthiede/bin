#!/bin/bash
BROWSER='qb-open'
if [[ $1 == "-a" || $1 == "add" || $1 == "a" ]];then
	echo "$2" "# $3"|tee -a ~/.bookmarks
else
	#wl-copy $(cat ~/.bookmarks | bemenu -p "copy:" -i -l 25 --tf "#ffffff" --hb "#285577" --hf "#ffffff" --fn "Hack 11"|cut -d "#" -f 1)
	LINK=$(cat ~/.bookmarks | bemenu -p "copy:" -i -l 25 --tf "#ffffff" --hb "#285577" --hf "#ffffff" --fn "Hack 11"|cut -d "#" -f 1)
	if [[ $LINK != '' ]];then
		$BROWSER $LINK
	fi
fi

