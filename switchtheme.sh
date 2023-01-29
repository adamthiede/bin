#!/bin/bash
#this switches my gtk theme and alacritty theme; I run it in cron
cd $HOME/.config/alacritty/
if [[ -z $(ls -l alacritty.yml|grep dark) ]];then
	ln -sf alacritty-dark.yml alacritty.yml
	gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
else
	ln -sf alacritty-light.yml alacritty.yml
	gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
fi
