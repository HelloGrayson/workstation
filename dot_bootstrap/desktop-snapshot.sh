#!/bin/bash

# Update dconf database
DCONF=$HOME/.bootstrap/dconf.ini
rm -f $DCONF
dconf dump / >$DCONF
chezmoi add $DCONF

# Backup to Backblaze
cd $HOME

# Init credentials
source $HOME/.bootstrap/restic-env

# Backup all files matching restic-includes.txt
restic backup --verbose --files-from=$HOME/.bootstrap/restic-includes.txt

# Store latest short_id in restic-latest
LATEST=$(restic snapshots --json | jq .[-1].short_id -r)
TRACKER=$HOME/.bootstrap/restic-latest
rm -f $TRACKER
echo $LATEST >>$TRACKER
chezmoi add $TRACKER
