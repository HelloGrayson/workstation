#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/Source/HelloGrayson/workstation/src/backup"

	bash "$WORKINGDIR/build-bin-restic.sh"
}

main "${@}"
