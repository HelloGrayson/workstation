#!/bin/sh

# Enable timesyncd to ensure correct clock
# Useful in the context of a VM snapshot
# @see https://github.com/twpayne/chezmoi/issues/3453
if ! systemctl is-enabled systemd-timesyncd; then
	sudo systemctl enable --now systemd-timesyncd
fi

# Ensure Bitwarden CLI available.
if ! command -v bw &>/dev/null; then
	cd ~/Downloads/
	wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
	unzip -u bw-linux-*.zip
	mkdir -p ~/bin
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

# Establish sudo access (lasts 15 mins).
sudo echo "First run..."

# Download and run Chezmoi
sh -c "$(curl -fsLSl get.chezmoi.io)" -- init --apply HelloGrayson
