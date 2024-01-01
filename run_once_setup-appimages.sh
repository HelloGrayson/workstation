#!/bin/bash
# Install AppImages into Gearlever.
# .desktop synced via ~/.local/applications w/ chezmoi.

mkdir -p ~/AppImages/
cd ~/AppImages/

# Balena Etcher - Flash OS images to SD cards & USB drives, safely and easily.
# @see https://etcher.balena.io/#download-etcher
#
if ! test -f gearlever_balenaetcher_e89f5c.appimage; then
	wget https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage
	mv balenaEtcher-1.18.11-x64.AppImage gearlever_balenaetcher_e89f5c.appimage
	chmod +x gearlever_balenaetcher_e89f5c.appimage
fi

# System76 Keyboard Configurator - Remap keys, swap keycaps, and configure multiple layers to your liking.
# @see https://system76.com/accessories/launch/download
#
if ! test -f gearlever_system76keyboardconfigurator_161104.appimage; then
	wget https://github.com/pop-os/keyboard-configurator/releases/download/v1.3.10/keyboard-configurator-1.3.10-x86_64.AppImage
	mv keyboard-configurator-1.3.10-x86_64.AppImage gearlever_system76keyboardconfigurator_161104.appimage
	chmod +x gearlever_system76keyboardconfigurator_161104.appimage
fi
