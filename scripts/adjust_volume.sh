#!/bin/bash

# Adjust volume
if [[ "$1" == "--increase" ]]; then
    current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -1)
    new_volume=$((current_volume + 5))
    if [[ $new_volume -gt 100 ]]; then
        new_volume=100
    fi
    pactl set-sink-volume @DEFAULT_SINK@ "${new_volume}%"
elif [[ "$1" == "--decrease" ]]; then
    current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -1)
    new_volume=$((current_volume - 5))
    if [[ $new_volume -lt 0 ]]; then
        new_volume=0
    fi
    pactl set-sink-volume @DEFAULT_SINK@ "${new_volume}%"
elif [[ "$1" == "--toggle-mute" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

# Get the current volume level and mute status
volume_level=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -1)
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )\w+')

# Determine the notification message
if [ "$is_muted" = "yes" ]; then
    message="Muted"
else
    message="Current volume: ${volume_level}%"
fi

# Send notification
notify-send -u low -h string:x-canonical-private-synchronous:volume "Volume" "$message"

