#!/bin/bash

store_url="https://extensions.gnome.org/extension-data"
cd ~/Downloads

# Setup Gnome Extension: AppIndicator Support
# @see https://extensions.gnome.org/extension/615/appindicator-support/
#
if ! gnome-extensions info appindicatorsupport@rgcjonas.gmail.com; then
	zip="appindicatorsupportrgcjonas.gmail.com.v57.shell-extension.zip"
	wget "$store_url/$zip"
	gnome-extensions install $zip --force
fi

# Setup Gnome Extension: Caffeine
# @see https://extensions.gnome.org/extension/517/caffeine/
#
if ! gnome-extensions info caffeine@patapon.info; then
	store_url="https://extensions.gnome.org/extension-data"
	zip="caffeinepatapon.info.v52.shell-extension.zip"
	wget "$store_url/$zip"
	gnome-extensions install $zip --force
fi
