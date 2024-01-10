#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/Source/HelloGrayson/workstation/backup"

	# Exit early if this machine is the one doing the snapshotting
	LEADER=$(head -1 "$WORKINGDIR/restic-leader")
	THIS=$(cat /etc/machine-id)
	if [ "$THIS" == "$LEADER" ]; then
		echo "Not the leader; gracefully exiting..."
		exit 0
	fi

	# Restore from home
	cd ~

	# Restore latest snapshot directly into $HOME
	restic restore --verbose --target "$HOME" latest

	# Restore dconf database
	dconf load -f / <"$HOME/.dconf.ini"
}

main "${@}"
