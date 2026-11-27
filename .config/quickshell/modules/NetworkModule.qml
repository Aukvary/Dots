import QtQuick
import "../services"
import "../components"

PillContainer {
    horizontalPadding: 15

    BarText {
        anchors.verticalCenter: parent.verticalCenter
        text: {
            if (!BarState.networkConnected) return "";
            if (BarState.networkIsWifi) return " ";
            if (BarState.targetNetworkDevice) return BarState.targetNetworkDevice.name + " ";
            return "";
        }
        color: BarState.accent
    }
}
