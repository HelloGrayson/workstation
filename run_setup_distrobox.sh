#!/bin/bash

# Build/update local/hellofedora container.
podman build -f ~/.bootstrap/Containerfile.fedora -t "localhost/fedora"

# Create/recreate HelloFedora distrobox.
exists=$(distrobox ls | grep Fedora)
echo $exists
if [[ -z $exists ]]; then
	echo "Fedora distrobox doesn't exist yet."
else
	distrobox stop -Y Fedora
	distrobox rm -Y Fedora
fi
SHELL=/usr/bin/zsh distrobox create --image localhost/fedora --name Fedora
distrobox upgrade Fedora # force init container

