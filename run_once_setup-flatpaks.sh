#!/usr/bin/bash
set -xeuo pipefail

# Silverblue pushes Linux towards a userspace fully-enclosed in $HOME.
# All of our interactions with flatpak should specify --user to leave as
# little trace in the host OS as possible and avoid the need for sudo.
#
# Unfortunately there is no way to change the default from --system to --user;
# we must pass --user to every command.
#
# @see https://github.com/flatpak/flatpak/issues/4099
#
flatpak remote-add --user --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

# Passwords and Keys - Manage PGP and SSH keys.
# @see https://flathub.org/apps/org.gnome.seahorse.Application
flatpak install --user --assumeyes flathub org.gnome.seahorse.Application

# Bitwarden - OSS secret storage as a service.
# @see https://flathub.org/apps/com.bitwarden.desktop
flatpak install --user --assumeyes flathub com.bitwarden.desktop

# Flatseal - Review and modify permissions from your Flatpak applications.
# @see https://flathub.org/apps/com.github.tchx84.Flatseal
flatpak install --user --assumeyes flathub com.github.tchx84.Flatseal

# Gear Lever - Manage AppImages with ease.
# @see https://flathub.org/apps/it.mijorus.gearlever
flatpak install --user --assumeyes flathub it.mijorus.gearlever

# Gnome Boxes - Easy Libvirt/QEMU VMs.
# @see https://flathub.org/apps/org.gnome.Boxes
flatpak install --user --assumeyes flathub org.gnome.Boxes

# Librewolf - Privacy and user freedom fork of Firefox.
# @see https://flathub.org/apps/io.gitlab.librewolf-community
flatpak install --user --assumeyes flathub io.gitlab.librewolf-community

# Ungoogled Chromium - A drop-in replacement for Chromium without Google web services.
# @see https://flathub.org/apps/com.github.Eloston.UngoogledChromium
flatpak install --user --assumeyes flathub com.github.Eloston.UngoogledChromium

# Mullvad Browser - A Tor-like browser for use with a VPN, instead of the Tor network.
# @see https://flathub.org/apps/net.mullvad.MullvadBrowser
flatpak install --user --assumeyes flathub net.mullvad.MullvadBrowser

# Tor Browser Launcher - Manage Tor Browser easily on GNU/Linux.
# @see https://flathub.org/apps/com.github.micahflee.torbrowser-launcher
flatpak install --user --assumeyes flathub com.github.micahflee.torbrowser-launcher

# Blanket - Whitenoise generator to improve focus and increase productivity.
# @see https://flathub.org/apps/com.rafaelmardojai.Blanket
flatpak install --user --assumeyes flathub com.rafaelmardojai.Blanket

# Spotify - Music streaming
# @see https://flathub.org/apps/com.spotify.Client
flatpak install --user --assumeyes flathub com.spotify.Client

# FreeTube - OSS TouTube client focused on privacy and freedom.
# @see https://flathub.org/apps/io.freetubeapp.FreeTube
flatpak install --user --assumeyes flathub io.freetubeapp.FreeTube

# NewsFlash - Native RSS client
# @see https://flathub.org/apps/io.gitlab.news_flash.NewsFlash
flatpak install --user --assumeyes flathub io.gitlab.news_flash.NewsFlash

# Telegram Desktop -  Use Telegram on Linux.
# @see https://flathub.org/apps/org.telegram.desktop
flatpak install --user --assumeyes flathub org.telegram.desktop
