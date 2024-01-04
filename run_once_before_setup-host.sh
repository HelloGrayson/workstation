#!/bin/bash

# Install preqequisites into a single rpm-ostree layer
rpm-ostree install \
	--assumeyes --apply-live --idempotent \
	fastfetch distrobox restic

# Install bw if not already.
if ! command -v bw &>/dev/null; then
	cd ~/Downloads/
	wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
	unzip -u bw-linux-*.zip
	mv bw ~/bin/
	chmod +x ~/bin/bw
fi
