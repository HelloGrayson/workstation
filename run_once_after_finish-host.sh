#!/bin/bash
#
# Wrap up host installation with items that ultimately require a system reboot.
#

# Mullvad - freedom and privacy-focused VPN.
#
# @see https://mullvad.net/en/why-mullvad-vpn
# @see https://mullvad.net/en/help/install-mullvad-app-linux#fedora
# @see https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_adding_external_package_repositories
#
if ! command -v mullvad &>/dev/null; then
	cd ~/Downloads/
	wget https://repository.mullvad.net/rpm/stable/mullvad.repo
	sudo install -o 0 -g 0 -m644 mullvad.repo /etc/yum.repos.d/mullvad.repo
	wget https://repository.mullvad.net/rpm/mullvad-keyring.asc
	sudo install -o 0 -g 0 -m644 mullvad-keyring.asc /etc/pki/rpm-gpg/mullvad-keyring.asc
	rpm-ostree install --assumeyes --apply-live mullvad-vpn
	sudo systemctl enable mullvad-daemon # app available after reboot
fi

# OpenSnitch - GNU/Linux application firewall.
#
# @see https://github.com/evilsocket/opensnitch
# @see https://github.com/evilsocket/opensnitch/wiki/Installation
# @see https://github.com/evilsocket/opensnitch/releases
# @see https://github.com/coreos/rpm-ostree/issues/1978
#
if ! command -v opensnitchd &>/dev/null; then
	cd ~/Downloads/
	wget https://github.com/evilsocket/opensnitch/releases/download/v1.6.2/opensnitch-1.6.2-1.x86_64.rpm
	wget https://github.com/evilsocket/opensnitch/releases/download/v1.6.4/opensnitch-ui-1.6.4-1.noarch.rpm
	rpm-ostree install --assumeyes --apply-live opensnitch-*.rpm
	sudo systemctl enable opensnitch # app available after reboot
fi

# Gnome Extension: Appindicator Support - KDE systray for Gnome.
#
# @see https://extensions.gnome.org/extension/615/appindicator-support/
#
if ! gnome-extensions info appindicatorsupport@rgcjonas.gmail.com; then
	store_url="https://extensions.gnome.org/extension-data"
	zip="appindicatorsupportrgcjonas.gmail.com.v57.shell-extension.zip"
	cd ~/Downloads/
	wget "$store_url/$zip"
	gnome-extensions install $zip --force # extension enabled after reboot
fi
