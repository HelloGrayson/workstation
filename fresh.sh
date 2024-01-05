#!/bin/sh
#
# Fully provision a fresh machine in a single command:
#
# $ sh -c "$(curl -fsLS https://raw.githubusercontent.com/HelloGrayson/dotfiles/main/init.sh)"
#
# This works by:
# 1. Initializing [sudo] in order to front-load credentialing.
# 2. Installing Bitwarden, login, and auth to front-load credentialing.
# 3. Install system level packages that require sudo.
# 4. Download Chezmoi, download this repo, then provision system.
# 5. Upgrade system packages, finalize install by rebooting.
#
# Cheers.
#

# Establish Bitwarden access.
#
# Setting $BW_SESSION within a chezmoi script
# does not actually grant every chezmoi script
# access to Bitwarden since environmental variables
# do not survive between shell sessions that Chezmoi 
# is presumably creating for each script.
#
# On a fresh machine, we can call into init.sh first and 
# then call into out Chezmoi program from it, making init.sh
# the parent script and allowing $BW_SESSION to be available 
# until the entire program concludes.
#
# In short, this means we can auth to Bitwarden once for the 
# entire installation without needing to reauthenticate.
#
if ! command -v bw &>/dev/null; then
  cd ~/Downloads/
  wget --content-disposition "https://vault.bitwarden.com/download/?app=cli&platform=linux"
  unzip -u bw-linux-*.zip
  mkdir -p ~/bin
  mv bw ~/bin/
  chmod +x ~/bin/bw
fi
if ! bw login --check; then
  echo "Logging into Bitwarden..."
  export BW_SESSION=$(bw login --raw)
fi
if ! bw unlock --check; then
  echo "Unlocking Bitwarden..."
  export BW_SESSION=$(bw unlock --raw)
fi

# Setup timesync, mullvad, and opensnitch.
# Enter sudo only once by running entire block as root.
# Now the user no longer needs to enter sudo several times while bootstrapping.
# This makes the entire install from the time sudo is entered unattended.
sudo -i -u root bash <<EOF

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
  cd ~/Downloads/
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
  cd ~/Downloads/
  wget https://github.com/evilsocket/opensnitch/releases/download/v1.6.2/opensnitch-1.6.2-1.x86_64.rpm
  wget https://github.com/evilsocket/opensnitch/releases/download/v1.6.4/opensnitch-ui-1.6.4-1.noarch.rpm
  rpm-ostree install --assumeyes --apply-live opensnitch-*.rpm
  systemctl enable opensnitch # app available after reboot # [sudo]
fi
EOF

# Download and run Chezmoi
if ! command -v chezmoi &>/dev/null; then
  cd $HOME
  sh -c "$(curl -fsLSk get.chezmoi.io)"
fi
chezmoi init --apply --verbose HelloGrayson

# Update system to latest packages,
# taking advantage of following reboot
rpm-ostree upgrade

# Finalize installation by Rebooting
# This is necessary for some components,
# like Mullvad, opensnitch, and the Gnome AppIndicator extension.
reboot
