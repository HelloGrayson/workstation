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

# Setup Gnome Extension: AppIndicator Support
# @see https://extensions.gnome.org/extension/615/appindicator-support/
#
if ! gnome-extensions info appindicatorsupport@rgcjonas.gmail.com; then
	store_url="https://extensions.gnome.org/extension-data"
	zip="appindicatorsupportrgcjonas.gmail.com.v57.shell-extension.zip"
	wget "$store_url/$zip"
	gnome-extensions install $zip --force
	gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
fi
