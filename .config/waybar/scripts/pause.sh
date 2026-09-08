#!/bin/bash
# Отключаем буферизацию
while true; do
    status=$(playerctl status)
    
    if [[ "$status" == "Playing" ]]; then
        echo '{"text": "⏸", "class": "playing"}'
    elif [[ "$status" == "Paused" ]]; then
        echo '{"text": "▶", "class": "paused"}'
    else
        echo '{"text": "⏹", "class": "stopped"}'
    fi
    
    sleep 0.1
done