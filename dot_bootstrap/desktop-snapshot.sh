#!/bin/bash

LEADER=$HOME/.bootstrap/restic-leader

# Only allow snapshot from leader...
# TODO create desktop-leader.sh which allows machine to set self as leader
# this would solve the issue of migrating to a new machine for primary use.
if [ $(cat /etc/machine-id) != $(head -1 $LEADER) ]; then
	echo "Not leader; gracefully exiting..."
	exit 0
fi

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

# Recreate leader file to
# track which machine did snapshot
MID=$(cat /etc/machine-id)
HOST=$(fastfetch | grep "Host: ")
OS=$(fastfetch | grep "OS: ")
rm -f $LEADER
echo $MID >>$LEADER
echo $HOST >>$LEADER
echo $OS >>$LEADER
chezmoi add $LEADER
