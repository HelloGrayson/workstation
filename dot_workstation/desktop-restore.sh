#!/usr/bin/bash
set -xeuo pipefail

main() {
	cd ~

	# Connect to Backblaze
	set +x
	source "$WORKSTATION/restic-export-creds.sh"
	set -x

	# Restore latest snapshot directly into $HOME
	restic restore --verbose --target "$HOME" latest

	# Restore dconf database
	dconf load -f / <"$HOME/.workstation/dconf.ini"
}

main "${@}"
