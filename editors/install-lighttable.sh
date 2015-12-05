#!/bin/bash

currentDir=$(pwd)
lighttableVer="0.8.0-alpha"
lighttableDir="lighttable-${lighttableVer}-linux"
lighttableTarball="${lighttableDir}.tar.gz"

echo "Downloading LightTable ${lighttableVer} to $USER's Downloads directory"
cd /home/$USER/Downloads && wget -q https://github.com/LightTable/LightTable/releases/download/$lighttableVer/$lighttableTarball # Download

cd "$currentDir"

echo "Removing any existing LightTable install (needs root)."
sudo rm -rf /usr/lib64/lighttable # Remove LightTable from /usr/lib64/lighttable
sudo rm -f /usr/bin/lighttable # Remove symlinks

echo "Installing LightTable ${lighttableVer}."
sudo mkdir -p /usr/lib64/lighttable
sudo tar -C /usr/lib64/lighttable -xzf /home/$USER/Downloads/$lighttableTarball # Extract LightTable
sudo mv /usr/lib64/lighttable/$lighttableDir/* /usr/lib64/lighttable/ # Move their stupid inner dir content to where it should be
sudo rmdir /usr/lib64/lighttable/$lighttableDir # Remove the empty dir

echo "Removing $lighttableTarball from $USER's Downloads directory."
rm /home/$USER/Downloads/$lighttableTarball

sudo ln -s /usr/lib64/lighttable/LightTable /usr/bin/lighttable # Do symlinks

if ! [ -f /usr/share/icons/lighttable.png ]; then # If there is no lighttable.png file
    echo "Installing LightTable logo."
    sudo wget http://lighttable.com/images/logo.png -qO /usr/share/icons/lighttable.png # Pull down lighttable.png and store it
fi

if ! [ -f /usr/share/applications/lighttable.desktop ]; then # If there is no lighttable.desktop file
    echo "Installing LightTable desktop file."
    sudo wget http://stroblindustries.com/solus-scripts/lighttable.desktop -qO /usr/share/applications/lighttable.desktop # Pull down lighttable.desktop and store it
fi

echo "LightTable installation finished. Have an issue? File at https://github.com/michaelrutherford/solus-scripts"
