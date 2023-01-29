#!/bin/sh
case $1/$2 in
  pre/*)
    echo "Going to $2..."
    # Place your pre suspend commands here, or `exit 0` if no pre suspend action required
    exit 0
    ;;
  post/*)
    echo "Waking up from $2..."
    # Place your post suspend (resume) commands here, or `exit 0` if no post suspend action required
    modprobe -r sky2
    modprobe sky2
    echo "$(date) this ran" >> /tmp/sky2modlog.txt
    ;;
esac
