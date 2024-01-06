#!/bin/bash
set -x

# Setup SSH (Fedora)
# @see https://unix.stackexchange.com/a/581000
# exec ssh-agent bash
ssh-add ~/.ssh/id_ed25519

# Setup GPG
# @see https://dev.to/mattdark/backup-and-restore-github-gpg-and-ssh-keys-2a12
gpg --import ~/.gnupg/HelloGrayson.asc
