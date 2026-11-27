import "../services"
import "../components"

PillContainer {
    horizontalPadding: 6

    ModuleItem {
        readonly property var icons: ["", "", ""]
        readonly property string icon: {
            const idx = Math.min(2, Math.floor(BarState.audioVolumePct * 3 / 101));
            return icons[Math.max(0, idx)];
        }

        text: BarState.audioMuted ? "󰖁" : (icon + "  " + BarState.audioVolumePct + "%")
        horizontalPadding: 2
        horizontalMargin: 1
        baseColor: BarState.accent
        hoverColor: BarState.hoverColor
        onClicked: BarState.toggleMute()
        onWheeled: wheel => BarState.stepVolume(wheel.angleDelta.y > 0 ? 0.02 : -0.02)
    }
}
