#!/usr/bin/env bash
# extract RPM files
if ! command -v "rpm2cpio" >/dev/null ;then
	echo "rpm2cpio does not exist. Install it. Bailing out."
	exit 1
fi
for rpmfile in ./*rpm; do
	echo "Extracting ${rpmfile} to ${rpmfile%.*}_contents..."
	if [ -d ${rpmfile%.*}_contents ];then
		echo -e "This directory already exists! You must have done this already.\nBailing out as to not overwrite contents."
		break
	fi
	mkdir -p ${rpmfile%.*}_contents
	cd ${rpmfile%.*}_contents
	rpm2cpio ../${rpmfile} | cpio -idmv
	cd ..
done
