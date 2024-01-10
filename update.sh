#!/usr/bin/bash
#
# Perform a full update of Silverblue workstation.

set -xeuo pipefail

main() {
	# TODO: update bw, chezmoi
	flatpak update --user --assumeyes
	distrobox upgrade --all
	rpm-ostree upgrade
}

main "${@}"
