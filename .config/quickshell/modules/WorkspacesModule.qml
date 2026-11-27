import QtQuick
import Quickshell.Hyprland
import "../services"
import "../components"

PillContainer {
    id: root

    required property var barWindow

    horizontalPadding: 6

    readonly property var monitorWorkspaces: {
        const all = Hyprland.workspaces ? Hyprland.workspaces.values : [];
        const screenName = root.barWindow && root.barWindow.screen ? root.barWindow.screen.name : "";
        const filtered = [];
        for (let i = 0; i < all.length; i++) {
            const ws = all[i];
            if (ws.id > 0 && (!screenName || (ws.monitor && ws.monitor.name === screenName))) {
                filtered.push(ws);
            }
        }
        filtered.sort((a, b) => a.id - b.id);
        return filtered;
    }

    onWheeled: wheel => {
        if (wheel.angleDelta.y > 0) {
            Hyprland.dispatch("workspace m-1");
        } else if (wheel.angleDelta.y < 0) {
            Hyprland.dispatch("workspace m+1");
        }
    }

    Repeater {
        model: root.monitorWorkspaces

        delegate: ModuleItem {
            required property HyprlandWorkspace modelData
            readonly property bool isActive: modelData.active

            text: modelData.name || String(modelData.id)
            horizontalPadding: isActive ? 2 : 3
            horizontalMargin: isActive ? 1 : 0
            baseColor: isActive ? BarState.accent : BarState.inactiveWorkspace
            hoverColor: isActive ? BarState.accent : BarState.textDefault
            onClicked: modelData.activate()
        }
    }
}
