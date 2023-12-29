#!/bin/bash

# Install distrobox onto Silverblue host.
if ! command -v distrobox &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live distrobox
fi

# Build localhost/fedora container.
podman build -f ~/.bootstrap/Containerfile.fedora -t "localhost/fedora"

# Setup Fedora distrobox
SHELL=/usr/bin/zsh distrobox create --image localhost/fedora --name Fedora
distrobox upgrade Fedora # force init container
