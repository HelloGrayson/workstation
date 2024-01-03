#!/bin/bash

flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

# Flatseal - Review and modify permissions from your Flatpak applications.
# @see https://flathub.org/apps/com.github.tchx84.Flatseal
flatpak install -y flathub com.github.tchx84.Flatseal

# Gear Lever - Manage AppImages with ease.
# @see https://flathub.org/apps/it.mijorus.gearlever
flatpak install -y flathub it.mijorus.gearlever

# Librewolf - Privacy and user freedom fork of Firefox.
# @see https://flathub.org/apps/io.gitlab.librewolf-community
flatpak install -y flathub io.gitlab.librewolf-community

# Ungoogled Chromium - A drop-in replacement for Chromium without Google web services.
# @see https://flathub.org/apps/com.github.Eloston.UngoogledChromium
flatpak install -y flathub com.github.Eloston.UngoogledChromium

# Mullvad Browser - A Tor-like browser for use with a VPN, instead of the Tor network.
# @see https://flathub.org/apps/net.mullvad.MullvadBrowser
flatpak install -y flathub net.mullvad.MullvadBrowser

# Tor Browser Launcher - Manage Tor Browser easily on GNU/Linux.
# @see https://flathub.org/apps/com.github.micahflee.torbrowser-launcher
flatpak install -y flathub com.github.micahflee.torbrowser-launcher

# Blanket - Whitenoise generator to improve focus and increase productivity.
# @see https://flathub.org/apps/com.rafaelmardojai.Blanket
flatpak install -y flathub com.rafaelmardojai.Blanket

# Spotify - Music streaming
# @see https://flathub.org/apps/com.spotify.Client
flatpak install -y flathub com.spotify.Client

# FreeTube - OSS TouTube client focused on privacy and freedom.
# @see https://flathub.org/apps/io.freetubeapp.FreeTube
flatpak install -y flathub io.freetubeapp.FreeTube

# NewsFlash - Native RSS client
# @see https://flathub.org/apps/io.gitlab.news_flash.NewsFlash
flatpak install -y flathub io.gitlab.news_flash.NewsFlash

# Telegram Desktop -  Use Telegram on Linux.
# @see https://flathub.org/apps/org.telegram.desktop
flatpak install -y flathub org.telegram.desktop
