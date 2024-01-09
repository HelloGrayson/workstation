#!/usr/bin/bash
# Update leader file with current machine
set -xeuo pipefail

main() {
	SRC="$(chezmoi data | jq .chezmoi.sourceDir -r)/src"

	LEADER="$SRC/restic-leader"
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
