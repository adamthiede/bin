#!/bin/bash
#simple program to put notes into Sync, if you have it
#if you don't, it uses your $HOME dir
#
#creates new note with current date/time in notes dir
#appends to the note if file exists
#accpets 1 argument as note body or reads 1 line
# if there are no args

notesdir="$HOME"

if [ -d $HOME/Sync/ ];then
	mkdir -p $HOME/Sync/Notes
	notesdir=$HOME/Sync/Notes
elif [ -d $HOME/Documents/Notes ]; then
	notesdir=$HOME/Documents/Notes
elif [ -d $HOME/Notes ];then
	notesdir=$HOME/Notes
else
	mkdir -p $HOME/Notes
	notesdir=$HOME/Notes
fi

name=$(date "+%Y-%m-%d_%H-%M").txt
fullpath=$notesdir/$name
notedata=""

if [ -z "$1" ]; then
	echo -e "Note only accepts one line. Enter text and press \"Enter\"."
	read -r notedata
elif [ "$1" = "-l" ];then
	ls -ltrha $notesdir
	exit 0
else
	notedata=$1
fi

if [ ! -e $fullpath ];then
	touch $fullpath
	echo $name > $fullpath
	echo $notedata >> $fullpath
	echo "Note created at $fullpath."
else
	echo $notedata >> $fullpath
	echo "Note appended at $fullpath."
fi
