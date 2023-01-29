#!/bin/bash

# This script just backs up good chunks of your home directory to a device you
# plug in.
# Exclusions:
# .cache - don't need it
# .local/share/containers - sometimes don't have permissions
# Music & Videos - back these up another way; they'll be huge in comparison.
# vm - place I keep VM images for libvirt.
# .local/var - postmarketos pmbootstrap directory

DEV="T5-1TB"
TM=$(date +'%H:%M:%S')

src="/home/${USER}/"
dest="/run/media/${USER}/${DEV}/${USER}_rsyncbkup/"

if [ -d /run/media/${USER}/${DEV}/ ];then
    sync
    echo "${TM} storage device ${DEV} present. Backing up."
	mkdir -p "${dest}"
	rsync -azu --delete \
	   	--exclude=.cache \
	   	--exclude=.local/share/containers \
	   	--exclude=Music \
	   	--exclude=Videos \
	   	--exclude=vm \
	   	--exclude=.local/var \
	   	$src $dest
    sync
    TM=$(date +'%H:%M:%S')
    echo "${TM} backup complete."
    exit 0
else
    echo "${TM} storage device named ${DEV} is not present. Not backing up!!"
    exit 1
fi
