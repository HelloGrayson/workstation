#!/bin/bash

# Install distrobox if not already.
if ! command -v distrobox &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live distrobox
	rpm-ostree install --assumeyes --aply-live python3-psutil
fi

# Install ansible if not already.
if ! command -v ansible &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live ansible
fi
