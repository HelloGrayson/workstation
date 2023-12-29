#!/bin/bash

# Install distrobox if not already.
if ! command -v distrobox &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live distrobox
fi

# Install ansible if not already.
if ! command -v ansible &>/dev/null; then
	pip install ansible
fi
