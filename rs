#!/bin/bash
BOX_NAME='alpine'
if [[ $DISTROBOX_ENTER_PATH || $TOOLBOX_PATH ]];then
	rustc $@ && ./${1::-3}
elif [[ $(command -v distrobox-enter) ]];then
	distrobox-enter $BOX_NAME -- rustc $@ && ./$(basename ${1::-3}) && rm ./$(basename ${1::-3})
elif [[ $(command -v toolbox) ]];then
	toolbox run rustc $@ && ./${1::-3} && rm ./${1::-3}
else
	echo "no distrobox or toolbox."
fi

