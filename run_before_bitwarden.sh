#!/bin/bash

# Ensure Bitwarden CLI available.
if ! command -v bw &>/dev/null; then
	cd ~/Downloads/
	wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
	unzip -u bw-linux-*.zip
	mv bw ~/bin/
	chmod +x ~/bin/bw
fi

# Establish Bitwarden access.
if ! bw login --check; then
	export BW_SESSION=$(bw login --raw)
fi
if ! bw unlock --check; then
	export BW_SESSION=$(bw unlock --raw)
fi

# Init sudo upfront if first ever run.
# This will allow a fully unattended installation.
if [ ! -d "$HOME/.bootstrap" ]; then
	sudo echo "First run..."
fi
