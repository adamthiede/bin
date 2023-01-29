#!/bin/bash
#find old podcasts and delete them
PODDIR=~/.local/share/newsboat/Podcasts/
find $PODDIR/ -type f -mtime +5 -delete
find $PODDIR/ -type d -empty -delete
