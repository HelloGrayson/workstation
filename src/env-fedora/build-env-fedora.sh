#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/Source/HelloGrayson/workstation/src/env-fedora"

	# Update localhost/fedora container.
	podman build -f "$WORKINGDIR/Containerfile.env-fedora" -t "localhost/env-fedora"

	# Recreate Fedora distrobox.
	if distrobox ls | grep env-fedora || false; then
		podman kill env-fedora
		distrobox rm -Y env-fedora
	fi
	SHELL=/usr/bin/zsh distrobox create --image localhost/env-fedora --name env-fedora
}

main "${@}"
