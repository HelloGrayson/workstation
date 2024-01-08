#!/usr/bin/bash
# Update leader file with current machine
set -xeuo pipefail

main() {
	WORKSTATION="$HOME/.workstation"
	LEADER="$WORKSTATION/restic-leader"
	MID=$(cat "/etc/machine-id")

	HOST=$(fastfetch | grep "Host: ")
	OS=$(fastfetch | grep "OS: ")

	rm -f "$LEADER"
	{
		echo "$MID"
		echo "$HOST"
		echo "$OS"
	} >>"$LEADER"

	chezmoi add "$LEADER"
}

main "${@}"
