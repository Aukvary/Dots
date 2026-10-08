#!/usr/bin/env bash

echo '{"version":1}'
echo '['
echo '[]'

# иконки батареи (JetBrainsMono Nerd Font, Material Design Icons)
battery_icon() {
    # $1 = процент заряда, $2 = charging/not
    if [ "$2" = yes ]; then
        case "$1" in
            [0-9]|10)       printf '󰢜' ;;  # battery_charging_10
            1[1-9]|20)      printf '󰂆' ;;  # battery_charging_20
            2[1-9]|30)      printf '󰂇' ;;  # battery_charging_30
            3[1-9]|40)      printf '󰂈' ;;  # battery_charging_40
            4[1-9]|50)      printf '󰢝' ;;  # battery_charging_50
            5[1-9]|60)      printf '󰂉' ;;  # battery_charging_60
            6[1-9]|70)      printf '󰂞' ;;  # battery_charging_70
            7[1-9]|80)      printf '󰂊' ;;  # battery_charging_80
            8[1-9]|90)      printf '󰂋' ;;  # battery_charging_90
            *)              printf '󰂅' ;;  # battery_charging_100
        esac
    elif [ "$1" -le 15 ]; then
        printf '󰂃'  # battery_alert
    else
        case "$1" in
            [0-9]|10)  printf '󰁺' ;;  # battery_10
            1[1-9]|20) printf '󰁻' ;;  # battery_20
            2[1-9]|30) printf '󰁼' ;;  # battery_30
            3[1-9]|40) printf '󰁽' ;;  # battery_40
            4[1-9]|50) printf '󰁾' ;;  # battery_50
            5[1-9]|60) printf '󰁿' ;;  # battery_60
            6[1-9]|70) printf '󰂀' ;;  # battery_70
            7[1-9]|80) printf '󰂁' ;;  # battery_80
            8[1-9]|90) printf '󰂂' ;;  # battery_90
            *)         printf '󰁹' ;;  # battery (полная)
        esac
    fi
}

# иконки wi-fi (по модулю RSSI, дБм; Material Design Icons)
net_icon() {
    case "$1" in
        [0-4][0-9] | 5[0-5]) printf '󰤨' ;;  # wifi_strength_4
        5[6-9] | 6[0-5])     printf '󰤥' ;;  # wifi_strength_3
        6[6-9] | 7[0-5])     printf '󰤢' ;;  # wifi_strength_2
        *)                   printf '󰤟' ;;  # wifi_strength_1
    esac
}

print_blocks() {
    layout="$(swaymsg -t get_inputs --raw 2>/dev/null |
        sed -n 's/.*"xkb_active_layout_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)"
    case "$layout" in
        "English (US)" | English*) layout="en" ;;
        Russian) layout="ru" ;;
        "") layout="?" ;;
    esac

    wpctl_out="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || true)"
    vol=""
    if [ -n "$wpctl_out" ]; then
        num="$(printf '%s' "$wpctl_out" | sed -n 's/.*\([0-9]\+\.[0-9]\+\).*/\1/p')"
        if [ -n "$num" ]; then
            percent="$(awk -v n="$num" 'BEGIN{printf "%d", n*100}')"
            case "$wpctl_out" in
                *MUTED* | *muted*) vol="󰖁 ${percent}%" ;;
                *)
                    if [ "$percent" -lt 34 ]; then
                        vol=" ${percent}%\t"
                    elif [ "$percent" -lt 67 ]; then
                        vol=" ${percent}%\t"
                    else
                        vol=" ${percent}%\t"
                    fi
                    ;;
            esac
        fi
    fi

    # сеть (iwd)
    eth_up=no
    wifi_iface=""
    for d in /sys/class/net/*/; do
        name="${d%/}"
        name="${name##*/}"
        [ "$name" = lo ] && continue
        if [ -d "$d/wireless" ]; then
            [ -z "$wifi_iface" ] && wifi_iface="$name"
        elif [ "$(cat "$d/operstate" 2>/dev/null)" = up ]; then
            eth_up=yes
        fi
    done
    net=""
    net_color=""
    if [ "$eth_up" = yes ]; then
        net="󰈀 eth\t"
        net_color="#a6e3a1"
    elif [ -n "$wifi_iface" ]; then
        net_info="$(iwctl station "$wifi_iface" show 2>/dev/null |
            sed -e 's/\x1b\[[0-9;]*m//g')"
        if printf '%s\n' "$net_info" | grep -q "Connected network"; then
            rssi="$(printf '%s\n' "$net_info" |
                sed -n 's/.*[^a-z]RSSI[[:space:]]*-*\([0-9][0-9]*\).*/\1/p' |
                head -1)"
            icon="$(net_icon "${rssi:-0}")"
            net="${icon}  "
            net_color="#a6e3a1"
        else
            net="󰤮 off\t"
            net_color="#f38ba8"
        fi
    fi

    total=0
    count=0
    charging=no
    for b in /sys/class/power_supply/BAT*; do
        [ -d "$b" ] || continue
        cap="$(cat "$b/capacity" 2>/dev/null || echo 0)"
        total=$((total + cap))
        count=$((count + 1))
        case "$(cat "$b/status" 2>/dev/null)" in
            Charging | Full) charging=yes ;;
        esac
    done
    bat=""
    if [ "$count" -gt 0 ]; then
        avg=$((total / count))
        icon="$(battery_icon "$avg" "$charging")"
        bat="${icon} ${avg}%\t"
    fi

    time_now="󰥔 $(date '+%H:%M')\t"
    date_now="󰃭 $(date '+%d.%m') "

    blocks=()
    blocks+=("{\"full_text\":\"${time_now}   ${date_now}\",\"color\":\"#cdd6f4\",\"separator\":false,\"separator_block_width\":0}")
    [ -n "$net" ] && blocks+=("{\"full_text\":\"${net}\",\"color\":\"${net_color}\",\"separator\":false,\"separator_block_width\":0}")
    [ -n "$bat" ] && blocks+=("{\"full_text\":\"${bat}\",\"color\":\"#cdd6f4\",\"separator\":false,\"separator_block_width\":0}")
    [ -n "$vol" ] && blocks+=("{\"full_text\":\"${vol}\",\"color\":\"#cdd6f4\",\"separator\":false,\"separator_block_width\":0}")
    blocks+=("{\"full_text\":\"[${layout}]\",\"color\":\"#cba6f7\",\"separator\":false,\"separator_block_width\":0}")

    printf ',['
    first=1
    for b in "${blocks[@]}"; do
        [ "$first" -eq 1 ] || printf ','
        printf '%s' "$b"
        first=0
    done
    printf ']\n'
}

while true; do
    print_blocks
    sleep 2
done
