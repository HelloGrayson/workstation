#!/bin/bash

cd $HOME

# Connect to Backblaze
source $HOME/.bootstrap/restic-env

# Backup all files matching restic-includes.txt
restic backup --verbose --files-from=$HOME/.bootstrap/restic-includes.txt

# Store latest short_id in restic-latest
LATEST=$(restic snapshots --json | jq .[-1].short_id -r)
TRACKER=$HOME/.bootstrap/restic-latest
rm -f $TRACKER
echo $LATEST >>$TRACKER
chezmoi add $TRACKER
