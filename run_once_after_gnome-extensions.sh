#!/bin/bash

# Setup Gnome Extension: AppIndicator Support
# @see https://extensions.gnome.org/extension/615/appindicator-support/
#
if ! gnome-extensions info appindicatorsupport@rgcjonas.gmail.com; then
	store_url="https://extensions.gnome.org/extension-data"
	zip="appindicatorsupportrgcjonas.gmail.com.v57.shell-extension.zip"
	wget "$store_url/$zip"
	gnome-extensions install $zip --force

	# Because Gnome+Wayland does not allow extensions to be installed
	# within the current session; enable does not work. The workaround
	# is to reboot the system, which luckily, enables the extensions
	# that were requested to be installed.
	# gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
	echo "AppIndicator install requested; reboot to enable."
fi
