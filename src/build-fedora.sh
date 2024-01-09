#!/usr/bin/bash
set -xeuo pipefail

main() {
	SRC="$(chezmoi data | jq .chezmoi.sourceDir -r)/src"

	# Update localhost/fedora container.
	podman build -f "$SRC/Containerfile.fedora" -t "localhost/fedora"

	# Recreate Fedora distrobox.
	if distrobox ls | grep Fedora || false; then
		podman kill Fedora
		distrobox rm -Y Fedora
	fi
	SHELL=/usr/bin/zsh distrobox create --image localhost/fedora --name Fedora
}

main "${@}"
