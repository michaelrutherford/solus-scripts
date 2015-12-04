#!/bin/bash

currentDir=$(pwd)

if ! [ -f /home/$USER/Downloads/go1.5.2.linux-amd64.tar.gz ]; then # If the go file doesnt exist
    echo "Downloading Go v1.5.2 to $USER's Downloads directory"
    cd /home/$USER/Downloads && wget https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz # Download
fi

cd "$currentDir"

echo "Removing any existing Go install (needs root)."
sudo rm -rf /usr/local/go # Remove go from /usr/local/go
sudo rm -f /usr/bin/go /usr/bin/godoc /usr/bin/gofmt # Remove symlinks

echo "Installing Go."
sudo tar -C /usr/local -xzf /home/$USER/Downloads/go1.5.2.linux-amd64.tar.gz # Extract go
sudo ln -s /usr/local/go/bin/{go,godoc,gofmt} /usr/bin/ # Do symlinks

gorootExists=$(grep -Fc "GOROOT" /home/$USER/.bashrc) # Get the number of instances of GOROOT

if [ $gorootExists -eq 0 ]; then # If there are no instances
    echo "No GOROOT detected in .bashrc, adding now."
    echo -e "\nexport GOROOT=/usr/local/go" >> /home/$USER/.bashrc # Echo (enabled backslash interpretation) of GOROOT

    echo "GOROOT added. go, godoc, and gofmt should work after:"
    echo "1) Restarting your terminal."
    echo "2) Opening a new terminal tab."
fi

echo "Go installation finished. Have an issue? File at https://github.com/michaelrutherford/solus-scripts"