#!/bin/bash
# Скрипт для отображения текущей музыки

player_status=$(playerctl status 2>/dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "{\"text\": \"$(playerctl metadata artist 2>/dev/null || echo 'Unknown') - $(playerctl metadata title 2>/dev/null | cut -c1-30)\", \"alt\": \"playing\", \"tooltip\": \"$(playerctl metadata title 2>/dev/null)\"}"
elif [ "$player_status" = "Paused" ]; then
    echo "{\"text\": \"⏸ $(playerctl metadata artist 2>/dev/null || echo 'Unknown') - $(playerctl metadata title 2>/dev/null | cut -c1-28)\", \"alt\": \"paused\", \"tooltip\": \"Paused: $(playerctl metadata title 2>/dev/null)\"}"
else
    echo "{\"text\": \"󰽰 No music\", \"alt\": \"stopped\", \"tooltip\": \"Click to play\"}"
fi