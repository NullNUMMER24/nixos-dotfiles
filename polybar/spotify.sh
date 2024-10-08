#!/bin/sh

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally

player_status=$(playerctl -p spotify status 2>&1 | tr -d '\r')
if [[ "$player_status" != "No players found" ]]; then
    metadata="$(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#29D398} $metadata"       # blue when playing
elif [[ $player_status = "Paused" ]]; then
    echo " $metadata"       # Greyed out info when paused
else
    echo ""
fi
