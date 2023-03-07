#!/bin/bash
# This script takes a link as an argument and saves the webpage as html
# in $dir so you can read it later. It also provides a handy links file
# to see where the pages came from. 

download=0
#options
while getopts ":d:h" o; do case "${o}" in
	d) download=1;;
	h) printf "Usage:\\n -h : print htis help message\\n -d : Download the page and add an \"original\" link as well as link to the download page in your links file." && exit ;;
	*) printf "Invalid option: -%s\\n" && exit ;;
esac done

#set vars, make directory
linkfile=$HOME/.linkfile.html
linkfile2=$HOME/.linkfile2.html
tmpfile=$HOME/.tmpfile.html
dir=$HOME/.linkfiles/
[ ! -d $dir ] && mkdir $dir
lname=$1
[ $download == "1" ] && lname=$2

placeContent(){
	fname="$(echo $pagetitle|md5sum --text -|awk '{print $1}').html"
	#content=$(wget $lname -q -O -)
	content=$(curl -q $lname)
	echo "$content" >> "${dir}/${fname}"
	echo "$section1" > $linkfile2
	echo "<li><a href="${dir}/${fname}">Offline Copy</a> ~ <a href=\"${lname}\" time_added=\"$(date +%s)\"  tags=\"${fname}\">${pagetitle}</a></li>" >> $linkfile2
	echo "$section2" >> $linkfile2

}

linkNoContent(){
	echo "$section1" > $linkfile2
	echo "<li><a href=\"${lname}\" time_added=\"$(date +%s)\"  tags=\"${fname}\">${pagetitle}</a></li>" >> $linkfile2
	echo "$section2" >> $linkfile2
}

# This is the main, non-optional part of the function.
# Here we slice up the file and get the link title, names, etc.
section1=$(head -n44 $linkfile)
filelines=$(wc -l $linkfile | awk '{print $1}')
count=$(expr $filelines - 44)
section2=$(tail -n$count $linkfile)
pagetitle=$(curl -q "$lname" | gawk -v IGNORECASE=1 -v RS='</title' 'RT{gsub(/.*<title[^>]*>/,"");print;exit}')
#pagetitle=$(wget -qO- "$lname" | gawk -v IGNORECASE=1 -v RS='</title' 'RT{gsub(/.*<title[^>]*>/,"");print;exit}')
# Here we either put a link to the content in, or
# download the content and put a link to it in our
# storage directory.
[ $download == "0" ] && linkNoContent
[ $download == "1" ] && placeContent

# this part moves the files around so that you always have a
# working file and it never gets cut up too much.
mv $linkfile $tmpfile
mv $linkfile2 $linkfile
rm $tmpfile 
