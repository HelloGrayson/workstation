#!/usr/bin/bash
set -xeuo pipefail

main() {
	SRC="$(chezmoi data | jq .chezmoi.sourceDir -r)/src"
	SNAPSHOT="$HOME/.restic"

	# Exit early if this machine is the one doing the snapshotting
	LEADER=$(head -1 "$SRC/restic-leader")
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
	dconf load -f / <"$SNAPSHOT/dconf.ini"
}

main "${@}"
