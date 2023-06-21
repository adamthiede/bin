#!/bin/bash
BROWSER="$HOME/.local/bin/qb-open"
BROWSER="$HOME/.local/bin/firefox"
if [[ $1 == "-a" || $1 == "add" || $1 == "a" ]];then
	line="$2"
	shift 2
	echo "$line" "# $@"|tee -a ~/.bookmarks
else
	#wl-copy $(cat ~/.bookmarks | bemenu -p "copy:" -i -l 25 --tf "#ffffff" --hb "#285577" --hf "#ffffff" --fn "Hack 11"|cut -d "#" -f 1)
	LINK=$(cat ~/.bookmarks | bemenu -p "copy:" -i -l 25 --tf "#ffffff" --hb "#285577" --hf "#ffffff" --fn "Monospace 11"|cut -d "#" -f 1)
	if [[ $LINK != '' ]];then
		$BROWSER $LINK
	fi
fi

