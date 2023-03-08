#!/bin/bash
# This script:
# - uploads a file to uguu.se
# - shows the URL
# - creates a log of uploaded files

function withclip {
	url=$(curl -s -F files[]=@${1} https://uguu.se/upload.php | jq -r '.files[].url')
	echo $url|tee -a $HOME/.local/share/uguu-uploads.log|$CLIP_CMD
	echo "Uploaded $1 to $url. URL copied to clipboard."

}
function noclip {
	curl -s -F files[]=@${1} https://uguu.se/upload.php\
		| jq -r '.files[]|.name + ": " +.url' \
		| tee -a $HOME/.local/share/uguu-uploads.log
}

if [[ $(command -v wl-copy) && ! -z $WAYLAND_DISPLAY ]];then
	# We have Wayland and wl-clipboard and can copy the URL to clipboard.
	# Assume Wayland first, because Wayland also can be true in the next case. 
	export CLIP_CMD='wl-copy'
	withclip $1

elif [[ $(command -v xclip) && ! -z $DISPLAY ]];then
	# We have X11 and xclip, and can copy url to clipboard.
	export CLIP_CMD='xclip'
	withclip $1
else
	noclip $1
fi

