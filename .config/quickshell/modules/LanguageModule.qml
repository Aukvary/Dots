import "../services"
import "../components"

PillContainer {
    horizontalPadding: 12

    ModuleItem {
        text: "󰇧 " + BarState.shortLanguage
        horizontalPadding: 0
        horizontalMargin: 0
        baseColor: BarState.accent
        hoverColor: BarState.hoverColor
        onClicked: BarState.cycleLanguage()
    }
}
