#!/bin/bash

# Function to send notification
send_notification() {
    brightness=$(brightnessctl g)
    max_brightness=$(brightnessctl m)
    brightness_percent=$(( brightness * 100 / max_brightness ))
    dunstify -t 1000 -r 2593 -u normal "Brightness: ${brightness_percent}%"
}

case $1 in
    up)
        brightnessctl set +10%
        send_notification
        ;;
    down)
        brightnessctl set 10%-
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

