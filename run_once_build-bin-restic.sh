#!/usr/bin/bash
set -xeuo pipefail

main() {
	SRC="$(chezmoi data | jq .chezmoi.sourceDir -r)/src"

	bash "$SRC/build-bin-restic.sh"
}

main "${@}"
