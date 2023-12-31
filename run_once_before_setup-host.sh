#!/bin/bash

# Install fastfetch if not already
if ! command -v fastfetch &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live fastfetch
fi

# Install distrobox if not already.
if ! command -v distrobox &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live distrobox
fi

# Install ansible if not already.
if ! command -v ansible &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live ansible
fi

# Install mullvad if not already.
#
# @see https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_adding_external_package_repositories
# @see https://mullvad.net/en/help/install-mullvad-app-linux#fedora
#
if ! command -v mullvad &>/dev/null; then
	cd ~/Downloads/
	wget https://repository.mullvad.net/rpm/stable/mullvad.repo
	sudo install -o 0 -g 0 -m644 mullvad.repo /etc/yum.repos.d/mullvad.repo
	wget https://repository.mullvad.net/rpm/mullvad-keyring.asc
	sudo install -o 0 -g 0 -m644 mullvad-keyring.asc /etc/pki/rpm-gpg/mullvad-keyring.asc
	rpm-ostree install --assumeyes --apply-live mullvad-vpn
	systemctl enable --now mullvad-daemon
	# the mullvad app will launch automatically on reboot
fi
