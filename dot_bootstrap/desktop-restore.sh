#!/bin/bash

cd $HOME

# Connect to Backblaze
source $HOME/.bootstrap/restic-env

# Restore latest snapshot directly into $HOME
restic restore --verbose --exclude user-dirs.dirs --target $HOME latest
