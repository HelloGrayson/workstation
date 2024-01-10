#!/usr/bin/bash
set -xeuo pipefail

main() {
	systemctl --user daemon-reload

	systemctl status --user backup-snapshot.service --full --no-pager || true

	systemctl enable --user --now backup-snapshot.timer
	systemctl start --user backup-snapshot.timer
	systemctl status --user backup-snapshot.timer --full --no-pager || true
	systemctl list-timers --user --all --no-pager
}

main "${@}"
