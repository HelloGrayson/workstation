#!/bin/bash

# Build localhost/fedora container.
podman build -f ~/.bootstrap/Containerfile.fedora -t "localhost/fedora"

# Setup Fedora distrobox
SHELL=/usr/bin/zsh distrobox create --image localhost/fedora --name Fedora
distrobox upgrade Fedora # force init container
