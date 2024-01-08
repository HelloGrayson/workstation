#!/usr/bin/bash
set -xeuo pipefail

cd ~

# Connect to Backblaze
source ~/.workstation/restic-env

# Restore latest snapshot directly into $HOME
restic restore --verbose --target "$HOME" latest

# Restore dconf database
dconf load -f / <"$HOME/.workstation/dconf.ini"
