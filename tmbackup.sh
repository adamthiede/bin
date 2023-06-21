#!/bin/sh
server="nas"
srcdir="/home/adam/"
[ -d /var/home/adam ] && srcdir="/var/home/adam/"
destdir="/volume1/Adam/timemachine/"
ssh $server hostname
if [[ ! $? -eq 0 ]];then
	echo "Cannot find backup server $server."
	exit 1
fi
# linux-timemachine src destserver:/destdir -- normal rsync opts
cd ~ 
timemachine "$srcdir" $server:"$destdir" -- \
--exclude vm \
--exclude Music \
--exclude Videos \
--exclude .cache \
--exclude .local/var/pmbootstrap \
--exclude .local/share/containers

