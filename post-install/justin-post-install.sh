#!/bin/bash

# Update full
sudo eopkg up -y
# Install developer packages
sudo eopkg it -c system.devel -y
# Install my apps
sudo eopkg it bmon feedreader gdm geany geary git glances gnome-clocks gnome-session gnome-shell hdparm htop kernel-headers nautilus-dropbox ncdu nmap nvidia-glx-driver openjdk-8 openssh-server pithos plank screen viewnior vinagre -y
# Install ISO tools
sudo eopkg it squashfs-tools syslinux libisoburn -y

#Enable/start ssh server
sudo systemctl enable sshd;sudo systemctl start sshd

#Add User Repo
sudo eopkg it pyyaml -y
sudo wget https://raw.githubusercontent.com/Justinzobel/surt/master/ur -O /usr/bin/ur;chmod +x /usr/bin/ur
sudo mkdir /var/db/surt;sudo chmod ug+rw /var/db/surt

#Mount storage/symlinks
sudo mkdir -p /mnt/storage
echo "/dev/sdc1 /mnt/storage ext4 defaults 0 0" | sudo tee -a /etc/fstab
echo "/mnt/storage/SwapFile none swap sw 0 0" | sudo tee -a /etc/fstab
sudo mount -a
sudo swapon /mnt/storage/SwapFile

#Symlink evobuild folders
sudo ln -s /mnt/storage/Solus/varlibevobuild /var/lib/evobuild
sudo ln -s /mnt/storage/Solus/varcacheevobuild /var/cache/evobuild

#ccache
sudo sed -i 's/# buildhelper = None/buildhelper = ccache/' /etc/eopkg/eopkg.conf

#yup/ep-up
ln -sfv /usr/share/ypkg/yupdate.py /usr/bin/yup
ln -sfv ~/Solus/repository/common/Scripts/ep-update.py /usr/bin/ep-update

#Home folder symlinks
rm -r ~/Downloads ~/Music ~/Pictures
cd
ln -s /mnt/storage ~/Storage
ln -s /mnt/storage/Solus/Builds ~/Builds
ln -s /mnt/storage/Downloads Downloads
ln -s /mnt/storage/Music ~/Music
ln -s /mnt/storage/Solus/repository ~/repository
ln -s /mnt/storage/Solus ~/Solus
ln -s /mnt/storage/Wallpapers ~/Pictures
ln -s "/mnt/storage/VirtualBox VMs" ~/

#Gsettings
#Theme/icons
gsettings set org.gnome.desktop.wm.preferences theme 'Arc-Darker'
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Darker'
#Fonts
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Droid Sans Bold 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Droid Sans Mono 10'
gsettings set org.gnome.desktop.interface font-name 'Droid Sans 10'
gsettings set org.gnome.desktop.interface document-font-name 'Droid Sans 10'
#gedit
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
gsettings set org.gnome.gedit.preferences.editor tabs-size "uint32 4"
gsettings set org.gnome.gedit.preferences.editor auto-indent true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
# budgie
gsettings set com.evolve-os.budgie.panel size 28
gsettings set com.evolve-os.budgie.panel gnome-panel-theme-integration true
gsettings set com.evolve-os.budgie.panel location 'top'
gsettings set com.evolve-os.budgie.panel menu-headers false
gsettings set com.evolve-os.budgie.panel menu-compact true
gsettings set com.evolve-os.budgie.panel menu-icons-size 18
gsettings set com.evolve-os.budgie.panel menu-icon 'start-here-symbolic'
gsettings set com.evolve-os.budgie.panel dark-theme true
# nautilus
gsettings set org.gnome.nautilus.preferences default-sort-in-reverse-order false
gsettings set org.gnome.nautilus.preferences default-sort-order 'name'
gsettings set org.gnome.nautilus.preferences sort-directories-first true
gsettings set org.gnome.nautilus.list-view default-zoom-level small
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
# terminal
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
