#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/.local/share/chezmoi/src/backup"

	bash "$WORKINGDIR/build-bin-restic.sh"
}

main "${@}"
