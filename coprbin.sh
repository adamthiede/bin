#!/bin/bash
VERSION_ID=$(rpm -E %fedora)
ARCH=$(arch)
PKGS=$(copr list-packages adamthiede/bin|jq '.[].name' -r|sort)
CHROOTS="fedora-${VERSION_ID}-${ARCH}"
if [[ -f ${1} ]];then
  copr build adamthiede/bin ${1} -r $CHROOTS
elif [[ ! -z ${1} && ${PKGS} =~ ${1} ]];then
  echo "${1} is in the pkg list. Building that."
  copr build-package adamthiede/bin --name ${1} -r $CHROOTS
else
  echo "type one of the following:"
  echo "${PKGS}"
  read -r -p 'Package: ' PKG
  copr build-package adamthiede/bin --name ${PKG} -r $CHROOTS
fi
