#!/bin/bash
BOX_NAME='alpine'
if [[ $DISTROBOX_ENTER_PATH || $TOOLBOX_PATH ]];then
	gcc $@ -o ${1::-2} && ./${1::-2}
elif [[ $(command -v distrobox-enter) ]];then
	distrobox-enter $BOX_NAME -- gcc $@ -o ${1::-2} && ./${1::-2}
elif [[ $(command -v toolbox) ]];then
	toolbox run gcc $@ -o ${1::-2} && ./${1::-2}
else
	echo "no distrobox or toolbox."
fi

