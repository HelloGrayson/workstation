#!/bin/bash

# Install ansible if not already.
if ! command -v ansible &>/dev/null; then
	echo "Installing ansible..."
	pip install ansible
	ansible --version
fi

# Run local playbook
ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass

echo "Ansible installation complete."
