#!/bin/sh

active_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.visible==true) | .name')

echo "$active_workspace"
