#!/usr/bin/bash
#
# Fully provision a fresh Fedora Silverblue.

set -x          # print all commands to terminal
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

main() {
	require_silverblue
	ensure_host_not_busy
	connect_to_bitwarden
	configure_root_os
	run_chezmoi
	rpm-ostree upgrade
}

# Enforce that script is being ran on Fedora Silverblue.
require_silverblue() {
	if ! cat /etc/*-release | grep Silverblue || false; then
		echo "Automation intended for Fedora Silverblue alone." 1>&2
		exit 1
	fi
}

# Ensure that rpm-ostree isn't in the middle of a transaction.
ensure_host_not_busy() {
	if ! rpm-ostree status | grep "State: idle" || false; then
		echo "Silverblue has a running transaction; try again after." 1>&6.2
		exit 1
	fi
}

# Auth to Bitwarden once for all further subshells.
connect_to_bitwarden() {
	if ! command -v bw &>/dev/null; then
		cd ~/Downloads/ || exit
		wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
		unzip -u bw-linux-*.zip
		mkdir -p ~/bin
		mv bw ~/bin/
		chmod +x ~/bin/bw
	fi
	if ! bw login --check; then
		BW_SESSION=$(bw login --raw)
		export BW_SESSION
	fi
	if ! bw unlock --check; then
		BW_SESSION=$(bw unlock --raw)
		export BW_SESSION
	fi
}

# Perform sudo-required host provisioning. This approach
# allows many sudo-required commands to run while only prompting for a
# single sudo password; ideal for unattended and long-running installations.
#
# @see https://superuser.com/a/1385156
configure_root_os() {
	cd ~/Downloads || exit
	sudo bash <<EOF

set -xeuo pipefail

# Enable systemd user services to run on boot & when logged out.
#
# @see https://brandonrozek.com/blog/non-root-systemd-scripts/
#
loginctl enable-linger "$USER" # [sudo]
loginctl show-user "$USER" # [sudo]

# Enable timesync to ensure correct clock
# 
# @see https://github.com/twpayne/chezmoi/issues/3453
#
if ! systemctl is-enabled systemd-timesyncd; then
  systemctl enable systemd-timesyncd # [sudo]
  systemctl start systemd-timesyncd # [sudo]
fi

# Mullvad - freedom and privacy-focused VPN.
#
# @see https://mullvad.net/en/why-mullvad-vpn
# @see https://mullvad.net/en/help/install-mullvad-app-linux#fedora
# @see https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_adding_external_package_repositories
#
if ! command -v mullvad &>/dev/null; then
  wget https://repository.mullvad.net/rpm/stable/mullvad.repo
  install -o 0 -g 0 -m644 mullvad.repo /etc/yum.repos.d/mullvad.repo # [sudo]
  wget https://repository.mullvad.net/rpm/mullvad-keyring.asc
  install -o 0 -g 0 -m644 mullvad-keyring.asc /etc/pki/rpm-gpg/mullvad-keyring.asc # [sudo]
  rpm-ostree install --assumeyes --apply-live mullvad-vpn
  systemctl enable mullvad-daemon # app available after reboot # [sudo]
fi

# OpenSnitch - GNU/Linux application firewall.
#
# @see https://github.com/evilsocket/opensnitch
# @see https://github.com/evilsocket/opensnitch/wiki/Installation
# @see https://github.com/evilsocket/opensnitch/releases
# @see https://github.com/coreos/rpm-ostree/issues/1978
#
if ! command -v opensnitchd &>/dev/null; then
  wget https://github.com/evilsocket/opensnitch/releases/download/v1.6.2/opensnitch-1.6.2-1.x86_64.rpm
  wget https://github.com/evilsocket/opensnitch/releases/download/v1.6.4/opensnitch-ui-1.6.4-1.noarch.rpm
  rpm-ostree install --assumeyes --apply-live opensnitch-*.rpm
  systemctl enable opensnitch # app available after reboot # [sudo]
fi

EOF
}

# Apply this repo's Chezmoi scripts to machine.
run_chezmoi() {
	if ! command -v chezmoi &>/dev/null; then
		cd "$HOME" || exit
		sh -c "$(curl -fsLSk get.chezmoi.io)"
	fi
	chezmoi init --apply --verbose HelloGrayson/workstation
}

main "${@}"
