#!/bin/bash
# Install AppImages into Gearlever.
# .desktop synced via ~/.local/applications w/ chezmoi.

mkdir -p ~/AppImages/
cd ~/AppImages/

# Balena Etcher - Flash OS images to SD cards & USB drives, safely and easily.
# @see https://etcher.balena.io/#download-etcher
#
if ! -f gearlever_balenaetcher_e89f5c.appimage; then
	wget https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage
	mv balenaEtcher-1.18.11-x64.AppImage gearlever_balenaetcher_e89f5c.appimage
	chmod +x gearlever_balenaetcher_e89f5c.appimage
fi
