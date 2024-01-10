#!/usr/bin/bash
set -xeuo pipefail

main() {
	WORKINGDIR="$HOME/.local/share/chezmoi/src/backup"
	SNAPSHOT="$HOME/.restic"

	LEADER="$WORKINGDIR/restic-leader"
	MID=$(cat "/etc/machine-id")

	# Only allow snapshot from leader...
	if [ "$MID" != "$(head -1 "$LEADER")" ]; then
		echo "Not leader; gracefully exiting..."
		exit 0
	fi

	# Update dconf database
	DCONF="$SNAPSHOT/dconf.ini"
	rm -f "$DCONF"
	dconf dump / >"$DCONF"

	# Backup to Backblaze
	cd ~

	# Backup all files matching restic-includes.txt
	restic backup --verbose --files-from="$WORKINGDIR/restic-includes.txt" --exclude-file="$WORKINGDIR/restic-excludes.txt"

	# Prune backups according to policy:
	#
	# @see https://restic.readthedocs.io/en/stable/060_forget.html#removing-snapshots-according-to-a-policy
	#
	# - Keep the last 7 daily snapshots.
	# - Keep 5 total snapshots for each of the last 5 weeks.
	# - Keep 12 total snapshots for each of thel last 12 months.
	# - Keep 60 total snapshots for each of the last 40 years.
	restic forget --prune --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 40

	# Display restic stats
	restic snapshots
	restic stats

	# Store latest short_id in restic-latest
	LATEST=$(restic snapshots --json | jq .[-1].short_id -r)
	TRACKER="$WORKINGDIR/restic-latest"
	rm -f "$TRACKER"
	echo "$LATEST" >>"$TRACKER"

	# Recreate leader file to
	# track which machine did snapshot
	HOST=$(fastfetch | grep "Host: ")
	OS=$(fastfetch | grep "OS: ")
	rm -f "$LEADER"
	{
		echo "$MID"
		echo "$HOST"
		echo "$OS"
	} >>"$LEADER"
}

main "${@}"
