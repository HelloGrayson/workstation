#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/Source/HelloGrayson/workstation/bin-chezmoi"

	# Build bin-chezmoi container
	podman build -f "$WORKINGDIR/Containerfile.bin-chezmoi" -t "localhost/bin-chezmoi"

	# Recreate bin-chezmoi distrobox
	if distrobox ls | grep bin-chezmoi || false; then
		podman kill bin-chezmoi
		distrobox rm -Y bin-chezmoi
	fi
	distrobox create --image localhost/bin-chezmoi --name bin-chezmoi
	distrobox enter bin-chezmoi -- chezmoi --version

	# Reexport chezmoi binary to user
	rm -f ~/bin/chezmoi
	distrobox enter bin-chezmoi -- distrobox-export --bin /usr/bin/chezmoi --export-path ~/.local/bin
}

main "${@}"
