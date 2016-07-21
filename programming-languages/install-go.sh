#!/bin/bash

currentDir=$(pwd)
goVer="1.6.3"
goTarball="go${goVer}.linux-amd64.tar.gz"
rcFile=".bashrc" # Default RC file to .bashrc

### Setup ###

if [ -f /home/$USER/.zshrc ]; then # If we are using zsh
    rcFile=".zshrc"
fi

if ! [ -f /home/$USER/Downloads/$goTarball ]; then # If the go file doesnt exist
    echo "Downloading Go v${goVer} to $USER's Downloads directory"
    cd /home/$USER/Downloads && wget -q https://storage.googleapis.com/golang/$goTarball # Download
fi

cd "$currentDir"

echo "===== Needs root. ====="

sudo mkdir -vp /usr/local # Make sure /usr/local exists in the first place

echo "Removing any existing Go install."
sudo rm -rf /usr/local/go # Remove go from /usr/local/go
sudo rm -fv /usr/bin/go /usr/bin/godoc /usr/bin/gofmt # Remove symlinks

echo "Installing Go v${goVer}"
sudo tar -C /usr/local -xzf /home/$USER/Downloads/$goTarball # Extract go
sudo ln -sv /usr/local/go/bin/{go,godoc,gofmt} /usr/bin/ # Do symlinks

gorootExists=$(grep -Fc "GOROOT=" /home/$USER/$rcFile) # Get the number of instances of GOROOT

if [ $gorootExists -eq 0 ]; then # If there are no instances
    echo "No GOROOT detected in ${rcFile}, adding now."
    echo -e "\nexport GOROOT=/usr/local/go" >> /home/$USER/$rcFile # Echo (enabled backslash interpretation) of GOROOT
    echo -e "\nexport PATH=$PATH:$GOPATH:$GOROOT/bin" >> /home/$USER/$rcFile

    echo "GOROOT added. go, godoc, and gofmt should work after:"
    echo "1) Restarting your terminal."
    echo "2) Opening a new terminal tab."
fi

echo "===== Go installation finished. ====="
echo "Have an issue? File at https://github.com/michaelrutherford/solus-scripts"
