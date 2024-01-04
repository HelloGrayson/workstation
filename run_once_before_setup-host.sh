#!/bin/bash

# Install preqequisites into a single rpm-ostree layer
rpm-ostree install \
	--assumeyes --apply-live --idempotent \
	fastfetch distrobox restic

# Gnome Extension: Appindicator Support - KDE systray for Gnome.
#
# @see https://extensions.gnome.org/extension/615/appindicator-support/
#
if ! gnome-extensions info appindicatorsupport@rgcjonas.gmail.com; then
	store_url="https://extensions.gnome.org/extension-data"
	zip="appindicatorsupportrgcjonas.gmail.com.v57.shell-extension.zip"
	cd ~/Downloads/
	wget "$store_url/$zip"
	gnome-extensions install $zip --force # extension enabled after reboot
fi
