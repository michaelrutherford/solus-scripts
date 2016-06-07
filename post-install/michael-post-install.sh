#!/bin/bash

# Upgrade
sudo eopkg up -y

# Developer packages
sudo eopkg it -c system.devel -y

# Applications
sudo eopkg it binutils clang gcc gedit-plugins ghex git glibc-devel htop libgtk-2-devel libgtk-3-devel libparted-devel kernel-headers nasm pkg-config yasm -y

# Google Chrome
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml &&
sudo eopkg it google-chrome-*.eopkg && sudo rm  google-chrome-*.eopkg

# ISO tools
sudo eopkg it squashfs-tools syslinux libisoburn -y

# gedit
gsettings set org.gnome.gedit.preferences.editor scheme 'solarized-dark'
gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
gsettings set org.gnome.gedit.preferences.editor tabs-size "uint32 8"
gsettings set org.gnome.gedit.preferences.editor auto-indent false
gsettings set org.gnome.gedit.preferences.editor insert-spaces true

# Budgie
gsettings set com.evolve-os.budgie.panel dark-theme true

# Git
git config --global user.name "Michael Rutherford"
git config --global user.email "michaellogan.rutherford@gmail.com"
cd ~
mkdir Projects
cd Projects
git clone https://github.com/michaelrutherford/solus-installer.git
cd ..


