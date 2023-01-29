#!/usr/bin/env bash
# journal.sh
# ==========
#
# One daily text file to rule them all.
#
# Copyright: 2022 Tyler Cipriani <tyler@tylercipriani.com
# License: GPLv3

set -euo pipefail

DATE="$(date --iso-8601=date)"
DATETIME="$(date --iso-8601=seconds)"

BASE="$HOME"/Documents/jrnl
WEBROOT="$HOME"/Documents/public_html/jrnl

mkdir -p "$BASE"
mkdir -p "$WEBROOT"

DAILY="$BASE"/"$DATE".md
DAILY_HTML="$WEBROOT"/"$DATE".html

has?() {
    command -v "$@" &> /dev/null
}
insert() {
    echo "$@" >> "$DAILY"
}

if [ ! -f "$DAILY" ]; then
    insert '---'
    insert "title: ${DATETIME}"
    insert "created: ${DATETIME}"
    insert '---'

    insert ''
fi

#vim -c 'Goyo' '+normal Go' "$DAILY"
vim "$DAILY"
#has? pandoc && pandoc -s -f markdown -t html5 -o "$DAILY_HTML" "$DAILY" || :
