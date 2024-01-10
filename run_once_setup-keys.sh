#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/Source/HelloGrayson/workstation"

	# So long as the user password manages the ~/.local/share/keyrings password,
	# Gnome will automatically unlock SSH and GPG keys.
	#
	# @see https://wiki.gnome.org/Projects/GnomeKeyring/

	# Setup SSH (Fedora)
	# @see https://unix.stackexchange.com/a/581000
	# exec ssh-agent bash
	#ssh-add ~/.ssh/id_ed25519 # Gnome Keyring does this.
	ls -al ~/.ssh

	# Setup GPG
	# @see https://dev.to/mattdark/backup-and-restore-github-gpg-and-ssh-keys-2a12
	#gpg --import ~/.gnupg/HelloGrayson.asc # Gnome Keyring does this.
	gpg --list-secret-keys --keyid-format LONG

	# Enable commit access to local Chezmoi repo
	# (HTTPS was the default to enable provisioning w/o SSH key)
	cd $WORKSTATION
	SSHREPO=git@github.com:HelloGrayson/workstation.git
	git remote set-url origin $SSHREPO
	git remote set-url --push origin $SSHREPO
}

main "${@}"
