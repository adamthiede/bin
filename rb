#!/bin/bash
BOX_NAME='alpine'
if [[ $DISTROBOX_ENTER_PATH || $TOOLBOX_PATH ]];then
	ruby $@
elif [[ $(command -v distrobox-enter) ]];then
	distrobox-enter $BOX_NAME -- ruby $@
elif [[ $(command -v toolbox) ]];then
	toolbox run ruby $@
else
	echo "no distrobox or toolbox."
fi

