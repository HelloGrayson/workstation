#!/bin/bash
set -x

# Setup SSH
exec ssh-agent bash
ssh-add ~/.ssh/id_ed25519

# Setup GPG
