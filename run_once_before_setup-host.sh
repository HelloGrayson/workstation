#!/bin/bash

# Install distrobox if not already.
if ! command -v distrobox &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live distrobox
fi

# Install ansible if not already.
if ! command -v ansible &>/dev/null; then
	rpm-ostree install --assumeyes --apply-live ansible

	# ansible's dconf module requires python3-psutil
	# @see https://docs.ansible.com/ansible/latest/collections/community/general/dconf_module.html
	rpm-ostree install --assumeyes --aply-live python3-psutil
fi
