#!/usr/bin/bash
#
# Perform a full update of Silverblue workstation.
#
# Manually managed: opensnitch & gnome appindicator plugin.

set -xeuo pipefail

main() {
	bw-upgrade
	chezmoi upgrade
	flatpak update --user --assumeyes
	distrobox upgrade --all
	rpm-ostree upgrade
}

bw-upgrade() {
	cd ~/Downloads/ || exit

	# get latest bw binary
	rm -rf bw-linux-*.zip
	wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
	unzip -u bw-linux-*.zip

	# replace bw
	rm -f ~/.local/bin/bw
	mv bw ~/.local/bin/
	chmod +x ~/.local/bin/bw
}

main "${@}"
