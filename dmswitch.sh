#!/bin/bash
# swtich between sddm and tinydm.

# add the following to a file in /etc/doas.d/:
# permit nopass :wheel cmd rc-update args add tinydm
# permit nopass :wheel cmd rc-update args del tinydm
# permit nopass :wheel cmd rc-update args add sddm
# permit nopass :wheel cmd rc-update args del sddm

use_sddm(){
	doas rc-update del tinydm
	doas rc-update add sddm
	echo "sddm is active"
}

use_tinydm(){
	doas rc-update del sddm 
	doas rc-update add tinydm
	echo "tinydm is active"
}

swap() {
	activedm=$(rc-update|grep dm\ \||awk '{print $1}')
	if [[ $activedm == "tinydm" ]];then
		use_sddm
	elif [[ $activedm == "sddm" ]];then
		use_tinydm
	else
		echo "active dm is not tinydm or sddm."
	fi
}

case $1 in
	"swap")
		swap && exit 0
		;;
	"sddm")
		use_sddm && exit 0
		;;
	"tinydm")
		use_tinydm && exit 0
		;;
	*)
		echo "run dmswitch.sh [swap/sddm/tinydm]"
		exit 1
		;;
esac

