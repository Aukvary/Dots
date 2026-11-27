import "../services"
import "../components"

PillContainer {
    visible: BarState.hasBattery
    horizontalPadding: 6

    ModuleItem {
        readonly property var defaultIcons: ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
        readonly property var chargingIcons: ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]
        readonly property string icon: {
            const arr = BarState.batteryCharging ? chargingIcons : defaultIcons;
            const idx = Math.max(0, Math.min(10, Math.round(BarState.batteryPct / 10)));
            return arr[idx];
        }

        text: BarState.batteryPct + "% " + icon
        horizontalPadding: 0
        horizontalMargin: 0
        baseColor: BarState.batteryCritical ? BarState.criticalColor : BarState.accent
        hoverColor: BarState.batteryCritical ? BarState.criticalColor : BarState.hoverColor
    }
}
