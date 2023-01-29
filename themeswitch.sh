#!/bin/bash
# need to get environment variable to run unattended
#export $(cat /proc/$(pgrep -u ${USER} ^phosh$)/environ |grep DBUS_SESSION_BUS_ADDRESS)
#export DBUS_SESSION_BUS_ADDRESS="$(cat /dev/shm/user/${UID}/dbus.bus)"

#gtk4 lookalike
#lt="adw-gtk3"
#dt="adw-gtk3-dark"
#pmos
#lt="postmarketos-light"
#dt="postmarketos-dark"
#normal
lt="Adwaita"
dt="Adwaita-dark"

curtheme=$(gsettings get org.gnome.desktop.interface gtk-theme)
scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
echo $scheme

setlight() {
	gsettings set org.gnome.desktop.interface gtk-theme $lt
	gsettings set org.gnome.desktop.interface color-scheme default
	sed -i -e 's/^theme=default/theme=papercolor-light/' $HOME/.config/tut/config.ini
	sed -i -e 's/*gdark/*glight/' $HOME/.config/alacritty/alacritty.yml
	sed -i -e 's/^set background=dark/set background=light/' $HOME/.vimrc
	#sed -i -e 's/gtk-application-prefer-dark-theme = 1/gtk-application-prefer-dark-theme = 0/' $HOME/.config/gtk-3.0/settings.ini
}
setdark() {
	gsettings set org.gnome.desktop.interface gtk-theme $dt
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	sed -i -e 's/^theme=papercolor-light/theme=default/' $HOME/.config/tut/config.ini
	sed -i -e 's/*glight/*gdark/' $HOME/.config/alacritty/alacritty.yml
	sed -i -e 's/^set background=light/set background=dark/' $HOME/.vimrc
	#sed -i -e 's/gtk-application-prefer-dark-theme = 0/gtk-application-prefer-dark-theme = 1/' $HOME/.config/gtk-3.0/settings.ini
}
swap(){
    if [ $scheme == "'default'" ];then
		setdark
    elif [ $scheme == "'prefer-dark'" ];then
		setlight
    fi
}

case "${1}" in
	"dark")
		setdark
		;;
	"light")
		setlight
		;;
	"")
		swap
		;;
	*)
		swap
		;;
esac

