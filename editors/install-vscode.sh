#!/bin/bash

shellDir=$(pwd)
vscodeUrl="https://az764295.vo.msecnd.net/stable/809e7b30e928e0c430141b3e6abf1f63aaf55589/code-stable-vscode-amd64.deb.tar.xz"
vscodeDirRoot="/opt/vscode-official"
tarballName="code-stable-vscode-amd64.deb.tar.xz"

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
	sudo tar -xf /home/$USER/Downloads/$tarballName
	sudo mv $vscodeDirRoot/VSCode-linux-x64/* $vscodeDirRoot/
	sudo rmdir $vscodeDirRoot/VSCode-linux-x64

	echo "Time travelling to the future."
	sudo install -Dm644 $shellDir/extras/vscode.desktop /usr/share/applications/vscode.desktop
	sudo cp $vscodeDirRoot/resources/app/resources/linux/code.png /usr/share/pixmaps/code.png
	sudo ln -fs $vscodeDirRoot/code /usr/bin/code
	
	rm /home/$USER/Downloads/$tarballName
	echo "We're here!"
fi
