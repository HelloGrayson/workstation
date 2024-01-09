#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$(chezmoi data | jq .chezmoi.sourceDir -r)/src/backup"

	bash "$WORKINGDIR/build-bin-restic.sh"
}

main "${@}"
