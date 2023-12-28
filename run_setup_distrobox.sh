#!/bin/bash

# Build/update local/hellofedora container.
podman build -f ~/.bootstrap/Containerfile.fedora -t hellofedora

# Create/recreate HelloFedora distrobox.
exists=$(distrobox ls | grep HelloFedora)
echo $exists
if [[ -z $exists ]] then
    echo "HelloFedora distrobox doesn't exist yet."
else
    distrobox stop -Y HelloFedora
    distrobox rm -Y HelloFedora
fi
SHELL=/usr/bin/zsh distrobox create --image localhost/hellofedora --name HelloFedora
distrobox upgrade HelloFedora # force init container