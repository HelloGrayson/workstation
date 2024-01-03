#!/bin/bash

# Connect to Backblaze
source $HOME/.bootstrap/restic-env

# Backup all files matching restic-includes.txt
restic backup --verbose --files-from=$HOME/.bootstrap/restic-includes.txt
