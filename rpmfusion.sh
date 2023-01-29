#!/bin/bash
#easy 'just do it' rpmfusion script
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf groupupdate core -y
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
dnf groupupdate sound-and-video -y
dnf install vim tmux mpv ffmpeg -y
dnf install rpmfusion-free-release-tainted -y
dnf install libdvdcss -y
