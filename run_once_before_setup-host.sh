#!/bin/bash

# Install preqequisites into a single rpm-ostree layer
rpm-ostree install \
	--assumeyes --apply-live --idempotent \
	fastfetch distrobox restic
