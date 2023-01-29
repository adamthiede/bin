#!/bin/bash
BOX_NAME='alpine'
if [[ $DISTROBOX_ENTER_PATH || $TOOLBOX_PATH ]];then
	go run $@
elif [[ $(command -v distrobox-enter) ]];then
	distrobox-enter $BOX_NAME -- go run $@
elif [[ $(command -v toolbox) ]];then
	toolbox run go run $@
else
	echo "no distrobox or toolbox."
fi

