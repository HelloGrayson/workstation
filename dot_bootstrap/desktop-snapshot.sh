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

# Track which machine updated last
MID=$(cat /etc/machine-id)
HOST=$(fastfetch | grep "Host: ")
OS=$(fastfetch | grep "OS: ")
MASTER=$HOME/.bootstrap/restic-master
rm -f $MASTER
echo $MID >>$MASTER
echo $HOST >>$MASTER
echo $OS >>$MASTER
chezmoi add $MASTER