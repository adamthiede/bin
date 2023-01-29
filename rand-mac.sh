#!/bin/bash

IFACE='wlan0'

# Disable the network devices
service networkmanager stop
sleep 5
ip link set dev $IFACE down

# Spoof the mac addresses
macchanger -r $IFACE
 
# Set a random hostname
old=$(cat /etc/hostname)
new=$(tr -dc 'A-Z0-9' < /dev/urandom | head -c7)
sed -i "s/$old/DESKTOP-$new/g" /etc/hosts
sed -i "s/$old/DESKTOP-$new/g" /etc/hostname
hostname "DESKTOP-$new"
echo Old hostname: $old
echo New hostname: $(hostname)

# Re-enable the devices
ip link set dev $IFACE up
service networkmanager start

exit 0

