#!/bin/bash
#clean out the empty dirs
find ~/.local/share/newsboat/Podcasts/ -type d -empty -delete
#renaming no longer needed.
#for dir in ~/.config/newsboat/Podcasts/* ; do
#	cd "$dir"
#	id3ren -template='%s.mp3' *
#done

blkdev=$(udisksctl status|grep "FiiO M5"|awk '{print $6}')

mount(){
	udisksctl mount -b "/dev/${blkdev}"
}

unmount(){
	udisksctl unmount -b "/dev/${blkdev}"
}

#if your mp3 player isn't mounted, then exit
[ ! -d "/run/media/${USER}/music" ] && echo "Not mounted" && mount 

mountpoint=$(df /run/media/${USER}/music|tail -n1 |cut -d " " -f 1)
rootmount=$(df / |tail -n1 |cut -d " " -f 1)

if [ $mountpoint != $rootmount ];then
	echo "Syncing Podcasts to $mountpoint..."
	rsync -tvrc --delete-after ~/.local/share/newsboat/Podcasts /run/media/${USER}/music/ && echo "media sync completed."
fi
unmount
