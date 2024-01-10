#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/.local/share/chezmoi/src/backup"

	# Build bin-restic container
	podman build -f "$WORKINGDIR/Containerfile.bin-restic" -t "localhost/bin-restic"

	# Recreate bin-restic distrobox
	if distrobox ls | grep bin-restic || false; then
		podman kill bin-restic
		distrobox rm -Y bin-restic
	fi
	distrobox create --image localhost/bin-restic --name bin-restic -a "--env-file ~/.restic/restic.env"
	distrobox enter bin-restic -- restic version

	# Reexport restic binary to user
	rm -f ~/bin/restic
	distrobox enter bin-restic -- distrobox-export --bin /usr/bin/restic --export-path ~/bin
}

main "${@}"
