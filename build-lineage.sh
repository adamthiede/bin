#! /bin/bash
# from https://www.disavowed.jp/lineageos/build-lineage.sh
# so long and thanks for all the fish, Chris
SITE=(INSERT_RSYNC_HOST_HERE)
USE_CCACHE=1
CCACHE_DIR=/mnt/ccache
ANDROID_DIR=/mnt/android
ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx8G"
RSYNC_OPTS="-acvzz"

function build_los {
	LOWER=`echo ${1} | tr [:upper:] [:lower:]`
	SEC_PATCH=$( grep 'PLATFORM_SECURITY_PATCH :=' build/core/version_defaults.mk | awk '{print $3}' )
	STAMP="`date '+%Y%m%d%H%M'`"
	brunch ${1} 1>/tmp/"${1}-${STAMP}-stdout" 2>/tmp/"${1}-${STAMP}-stderr"
	BLEAH=$?
	echo "exit status is ${BLEAH}" 1>&2

	if test ${BLEAH} = "0"; then
		echo "Security patchlevel ${SEC_PATCH}" 1>&2
		for i in out/target/product/${1}/lineage-*; do
			touch -t "`echo $i | sed 's,^.*-\([0-9]*\)-.*$,\1,g'`"0000 "$i"
		done

		make addonsu addonsu-remove

		( cd out/target/product/${1}/
		  find -type f \( -name "lineage-*zip" -o -name "addonsu*zip*" \) -mtime -2 > /tmp/x-${USER}
		  rsync -avzz `cat /tmp/x-${USER}` ${SITE}:lineageos/${LOWER}/
		)

		ssh ${SITE} \
			"cat lineageos/${LOWER}/HEADER.md.tmpl | sed \"s,%PATCH%,${SEC_PATCH},g\" > lineageos/${LOWER}/HEADER.md"
	fi
}

function build_branch {
	cd ${ANDROID_DIR}/lineage${1}
	source build/envsetup.sh
	BRANCH_DEVICES="DEVICES"

	for i in ${!BRANCH_DEVICES}; do
		(>&2 echo "--- Building for ${i} ---")
		CCACHE_DIR=/mnt/ccache/ccache${1}
		build_los ${i}
	done

	prebuilts/sdk/tools/jack-admin stop-server 2>&1
	prebuilts/sdk/tools/jack-admin cleanup-server 2>&1
}

for i in "$@"; do
	case $i in
		--ccache=*)
			USE_CCACHE="${i#*=}"
			;;
		--branch=*)
			BRANCH="${i#*=}"
			;;
		--site=*)
			SITE="${i#*=}"
			;;
		--device=*)
			D="${i#*=}"
			DEVICES="`echo $D | tr , ' '`"
			;;
		*)
			# unknown option
			;;
	esac
done

export PATH=${ANDROID_DIR}/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
export LC_ALL=C
export USE_CCACHE
export CCACHE_DIR
export ANDROID_JACK_VM_ARGS


for i in ${BRANCH}; do
	(>&2 echo "--- Building branch ${i} ---")
	build_branch ${i}
done
