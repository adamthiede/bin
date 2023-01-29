#!/bin/bash
WIFI_STATUS=$(nmcli radio wifi)
if [ "${WIFI_STATUS}" == "disabled" ];then
    echo "  Enabling WiFi"
    nmcli radio wifi on
elif [ "${WIFI_STATUS}" == "enabled" ];then
    echo "  Disabling WiFi"
    nmcli radio wifi off
fi
