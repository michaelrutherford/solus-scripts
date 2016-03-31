#!/bin/bash

shellDir=$(pwd)
vscodeUrl="https://go.microsoft.com/fwlink/?LinkID=620884"
vscodeDirRoot="/opt/vscode-official"
tarballName="vscode.zip"

echo "Did you know, we already offer the open source community version of Visual Studio Code?"
echo "Do you want to install that instead? (y/N)"
read installOSS

if [[ $installOSS == *"yes"* ]] # If we should install the OSS version
then
	sudo eopkg install vscode
else
	echo "Downloading Visual Studio Code from Microsoft"
	cd /home/$USER/Downloads && wget -q $vscodeUrl -O $tarballName # Download

	echo "Bootstrapping..."
	sudo rm -rf $vscodeDirRoot # Ensure existing VSCode content is removed
	sudo mkdir -p $vscodeDirRoot # Ensure VSCode dir is created
	cd $vscodeDirRoot # Go to VSCode directory

	echo "Unpackaging..."
	sudo unzip -qq /home/$USER/Downloads/$tarballName
	sudo mv $vscodeDirRoot/VSCode-linux-x64/* $vscodeDirRoot/
	sudo rmdir $vscodeDirRoot/VSCode-linux-x64

	echo "Time travelling to the future."
	sudo install -Dm644 $shellDir/extras/vscode.desktop /usr/share/applications/vscode.desktop
	sudo cp $vscodeDirRoot/resources/app/resources/linux/code.png /usr/share/pixmaps/code.png
	sudo ln -s $vscodeDirRoot/code /usr/bin/code
	
	rm /home/$USER/Downloads/$tarballName
	echo "We're here!"
fi