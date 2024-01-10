#!/usr/bin/bash
# Update leader file with current machine
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/Source/HelloGrayson/workstation/src/backup"

	LEADER="$WORKINGDIR/restic-leader"
	MID=$(cat "/etc/machine-id")

	HOST=$(fastfetch | grep "Host: ")
	OS=$(fastfetch | grep "OS: ")

	rm -f "$LEADER"
	{
		echo "$MID"
		echo "$HOST"
		echo "$OS"
	} >>"$LEADER"
}

main "${@}"
