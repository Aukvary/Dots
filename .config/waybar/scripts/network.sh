#!/usr/bin/env bash
# Waybar network widget: wifi signal strength icon.
# Reads RSSI from the kernel (works with iwd/connman-compat, no D-Bus needed).
set -uo pipefail

IFACE="wlan0"

rssi=$(iw dev "$IFACE" station dump 2>/dev/null | awk '/signal:/{print $2; exit}')

# Not connected / no station -> offline icon
if [ -z "$rssi" ]; then
    echo "󰤭"
    exit 0
fi

# Map dBm to 0..100: -90 dBm -> 0%, -50 dBm -> 100%
pct=$(( (rssi + 90) * 100 / 40 ))
if [ "$pct" -lt 0 ]; then pct=0; fi
if [ "$pct" -gt 100 ]; then pct=100; fi

if   [ "$pct" -lt 20 ]; then icon="󰤏"
elif [ "$pct" -lt 40 ]; then icon="󰤐"
elif [ "$pct" -lt 60 ]; then icon="󰤑"
elif [ "$pct" -lt 80 ]; then icon="󰤒"
else                          icon="󰤞"
fi

echo "$icon"
