#!/bin/sh
server="mini"
srcdir="/home/adam/"
destdir="/mnt/data/adam_bkup/"
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
--exclude .local/var/pmbootstrap \
--exclude .local/share/containers

