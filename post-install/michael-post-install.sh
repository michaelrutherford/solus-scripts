#!/bin/bash

# Upgrade everything
sudo eopkg up -y

# Install developer packages
sudo eopkg it -c system.devel -y

# Install my applications
sudo eopkg it binutils clang gcc geany gedit-plugins ghex git glibc-devel htop libgtk-2-devel libgtk-3-devel libparted-devel kernel-headers nasm pkg-config yasm -y

# Install Google Chrome
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml &&
sudo eopkg it google-chrome-*.eopkg && sudo rm  google-chrome-*.eopkg

# Install ISO tools
sudo eopkg it squashfs-tools syslinux libisoburn -y

# Gsettings
#Theme/icons
gsettings set org.gnome.desktop.wm.preferences theme 'Arc-Darker'
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Darker'

# gedit
gsettings set org.gnome.gedit.preferences.editor scheme 'solarized-dark'
gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
gsettings set org.gnome.gedit.preferences.editor tabs-size "uint32 8"
gsettings set org.gnome.gedit.preferences.editor auto-indent false
gsettings set org.gnome.gedit.preferences.editor insert-spaces true

# budgie
gsettings set com.evolve-os.budgie.panel dark-theme true
