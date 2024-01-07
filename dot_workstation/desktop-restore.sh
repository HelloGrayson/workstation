#!/usr/bin/bash
set -xeuo pipefail

cd $HOME

# Connect to Backblaze
source $HOME/.workstation/restic-env

# Restore latest snapshot directly into $HOME
restic restore --verbose --exclude user-dirs.dirs --target $HOME latest

# Restore dconf database
dconf load -f / <$HOME/.workstation/dconf.ini
