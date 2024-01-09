#!/usr/bin/bash

export $(cat "$HOME/.workstation/restic.env" | xargs)
