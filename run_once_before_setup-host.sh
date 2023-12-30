#!/bin/bash

# Install fastfetch if not already
if ! command -v fastfetch &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live fastfetch
fi

# Install distrobox if not already.
if ! command -v distrobox &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live distrobox
fi

# Install ansible if not already.
if ! command -v ansible &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live ansible
fi
