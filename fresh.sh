#!/bin/sh
#
# Fully provision a fresh machine in a single command:
#
# $ sh -c "$(curl -fsLS https://raw.githubusercontent.com/HelloGrayson/dotfiles/main/init.sh)"
#
# This works by:
# 1. Installing Bitwarden and setting $BW_SESSION for Chezmoi program.
# 2. Downloading Chezmoi, setting up this repo locally, and running.
# 3. Rebooting machine to finalize installation.
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
	export BW_SESSION=$(bw login --raw)
fi
if ! bw unlock --check; then
  export BW_SESSION=$(bw unlock --raw)
fi

# Establish sudo access (lasts 15 mins).
sudo echo "First run..."

# Enable timesyncd to ensure correct clock
# Useful in the context of a VM snapshot
# @see https://github.com/twpayne/chezmoi/issues/3453
if ! systemctl is-enabled systemd-timesyncd; then
	sudo systemctl enable --now systemd-timesyncd
  sudo systemctl start systemd-timesyncd
fi

# Download and run Chezmoi
if ! command -v chezmoi &>/dev/null; then
  cd $HOME
  sh -c "$(curl -fsLSk get.chezmoi.io)"
fi
chezmoi init --apply --verbose HelloGrayson

# Finalize installation by Rebooting
# This is necessary for some components,
# like Mullvad, opensnitch, and the Gnome AppIndicator extension.
reboot
