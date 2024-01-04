#!/bin/bash

# Install bw if not already.
if ! command -v bw &>/dev/null; then
	cd ~/Downloads/
	wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
	unzip -u bw-linux-*.zip
	mv bw ~/bin/
	chmod +x ~/bin/bw
fi

# Login if not already.
if ! bw login --check; then
	export BW_SESSION=$(bw login --raw)
fi
