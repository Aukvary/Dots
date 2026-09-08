#!/bin/bash
STATE_FILE="/tmp/waybar-power-menu.state"

[[ ! -f "$STATE_FILE" ]] && echo "collapsed" > "$STATE_FILE"
STATE=$(cat "$STATE_FILE")

if [[ "$1" == "toggle" ]]; then
    if [[ "$STATE" == "collapsed" ]]; then
        echo "expanded" > "$STATE_FILE"
    else
        echo "collapsed" > "$STATE_FILE"
    fi
    STATE=$(cat "$STATE_FILE")
fi

if [[ "$STATE" == "expanded" ]]; then
    echo '{"text": "▶", "class": "expanded"}'
else
    echo '{"text": " ", "class": "collapsed"}'
fi

pkill -RTMIN+8 waybar