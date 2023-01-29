#!/usr/bin/env bash
PWR_STATUS=$(powerprofilesctl get)
if [ "${PWR_STATUS}" == "balanced" ];then
    echo -e "⚡ Switching from $PWR_STATUS to power saver"
    powerprofilesctl set power-saver
elif [ "${PWR_STATUS}" == "enabled" ];then
    echo -e "⚡ Switching from $PWR_STATUS to balanced"
    powerprofilesctl set balanced
else
    echo -e "⚡ Switching from $PWR_STATUS to balanced"
    powerprofilesctl set balanced
fi
