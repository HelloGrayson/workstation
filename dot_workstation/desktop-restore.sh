#!/usr/bin/bash
set -xeuo pipefail

main() {
	cd ~

	# Restore latest snapshot directly into $HOME
	restic restore --verbose --target "$HOME" latest

	# Restore dconf database
	dconf load -f / <"$HOME/.workstation/dconf.ini"
}

main "${@}"
