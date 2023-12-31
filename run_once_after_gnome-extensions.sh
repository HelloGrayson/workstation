#!/bin/bash

# Setup Gnome Extension: AppIndicator Support
# @see https://extensions.gnome.org/extension/615/appindicator-support/
#
if ! gnome-extensions info appindicatorsupport@rgcjonas.gmail.com; then
	store_url="https://extensions.gnome.org/extension-data"
	zip="appindicatorsupportrgcjonas.gmail.com.v57.shell-extension.zip"
	wget "$store_url/$zip"
	gnome-extensions install $zip --force
fi

reboot
