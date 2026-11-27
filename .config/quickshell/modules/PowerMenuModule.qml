import QtQuick
import Quickshell
import "../services"
import "../components"

PillContainer {
    id: root

    required property var barWindow
    readonly property bool popupOpen: controlPopup.open

    horizontalPadding: 6

    ModuleItem {
        text: "󱪇"
        fontSize: BarState.iconFontSize
        horizontalPadding: 10
        horizontalMargin: 1
        baseColor: BarState.accent
        hoverColor: BarState.hoverColor
        onClicked: Quickshell.execDetached(["footclient"])
    }

    HoverPopup {
        id: controlPopup
        barWindow: root.barWindow
        anchorItem: root
        triggerHovered: root.hovered
        popupPadding: 12
        forceOpen: sliderMouse.pressed

        Column {
            width: 264
            spacing: 10

            // Row 1: Poweroff & Reboot
            Row {
                width: parent.width
                spacing: 8

                Rectangle {
                    width: (parent.width - parent.spacing) / 2
                    height: 34
                    color: poweroffMouse.containsMouse
                        ? Qt.rgba(243 / 255, 139 / 255, 168 / 255, 0.16)
                        : Qt.rgba(1, 1, 1, 0.04)
                    border.width: 1
                    border.color: BarState.pillBorder

                    BarText {
                        anchors.centerIn: parent
                        text: "⏻"
                        font.pixelSize: 18
                        color: poweroffMouse.containsMouse ? BarState.hoverColor : BarState.poweroffColor
                    }

                    MouseArea {
                        id: poweroffMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
                    }
                }

                Rectangle {
                    width: (parent.width - parent.spacing) / 2
                    height: 34
                    color: rebootMouse.containsMouse
                        ? Qt.rgba(249 / 255, 226 / 255, 175 / 255, 0.16)
                        : Qt.rgba(1, 1, 1, 0.04)
                    border.width: 1
                    border.color: BarState.pillBorder

                    BarText {
                        anchors.centerIn: parent
                        text: "🗘"
                        font.pixelSize: 18
                        color: rebootMouse.containsMouse ? BarState.hoverColor : BarState.rebootColor
                    }

                    MouseArea {
                        id: rebootMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Quickshell.execDetached(["systemctl", "reboot"])
                    }
                }
            }

            // Row 2: Volume slider + percentage
            Rectangle {
                width: parent.width
                height: 36
                color: Qt.rgba(1, 1, 1, 0.04)
                border.width: 1
                border.color: BarState.pillBorder

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 10

                    ModuleItem {
                        readonly property var icons: ["", "", ""]
                        readonly property string icon: {
                            const idx = Math.min(2, Math.floor(BarState.audioVolumePct * 3 / 101));
                            return icons[Math.max(0, idx)];
                        }

                        height: parent.height
                        text: BarState.audioMuted ? "󰖁" : icon
                        fontSize: 16
                        horizontalPadding: 2
                        horizontalMargin: 0
                        baseColor: BarState.accent
                        hoverColor: BarState.hoverColor
                        onClicked: BarState.toggleMute()
                        onWheeled: wheel => BarState.stepVolume(wheel.angleDelta.y > 0 ? 0.02 : -0.02)
                    }

                    Item {
                        width: parent.width - 24 - 46 - (parent.spacing * 2)
                        height: parent.height

                        Rectangle {
                            id: trough
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: 8
                            color: BarState.sliderTrough

                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: Math.max(0, Math.min(1.0, BarState.audioVolumePct / 100.0)) * parent.width
                                color: BarState.accent
                            }

                            MouseArea {
                                id: sliderMouse
                                anchors.fill: parent
                                anchors.topMargin: -10
                                anchors.bottomMargin: -10
                                cursorShape: Qt.PointingHandCursor
                                preventStealing: true

                                function applyMouse(mx) {
                                    const ratio = Math.max(0, Math.min(1.0, mx / trough.width));
                                    BarState.setVolume(ratio);
                                }

                                onPressed: mouse => applyMouse(mouse.x)
                                onPositionChanged: mouse => {
                                    if (pressed) applyMouse(mouse.x);
                                }
                                onWheel: wheel => BarState.stepVolume(wheel.angleDelta.y > 0 ? 0.02 : -0.02)
                            }
                        }
                    }

                    BarText {
                        width: 46
                        height: parent.height
                        horizontalAlignment: Text.AlignRight
                        text: BarState.audioVolumePct + "%"
                        font.pixelSize: 14
                        color: BarState.audioMuted ? BarState.inactiveWorkspace : BarState.accent
                    }
                }
            }

            // Row 3: Connected network name
            Rectangle {
                width: parent.width
                height: 34
                color: Qt.rgba(1, 1, 1, 0.04)
                border.width: 1
                border.color: BarState.pillBorder

                readonly property string netIcon: {
                    if (!BarState.networkConnected) return "";
                    return BarState.networkIsWifi ? "" : "";
                }

                Item {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    BarText {
                        id: netIconLabel
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: parent.parent.netIcon
                        font.pixelSize: 15
                        color: BarState.networkConnected ? BarState.accent : BarState.criticalColor
                    }

                    BarText {
                        anchors.left: netIconLabel.right
                        anchors.leftMargin: 8
                        anchors.right: netSigLabel.visible ? netSigLabel.left : parent.right
                        anchors.rightMargin: netSigLabel.visible ? 8 : 0
                        anchors.verticalCenter: parent.verticalCenter
                        text: BarState.networkDisplayName
                        font.pixelSize: 14
                        color: BarState.networkConnected ? BarState.textDefault : BarState.inactiveWorkspace
                        elide: Text.ElideRight
                    }

                    BarText {
                        id: netSigLabel
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        visible: BarState.networkConnected && BarState.networkIsWifi
                        text: BarState.networkSignalPct + "%"
                        font.pixelSize: 13
                        color: BarState.inactiveWorkspace
                    }
                }
            }

            // Row 4: Bluetooth status & Language
            Row {
                width: parent.width
                spacing: 8

                Rectangle {
                    width: (parent.width - parent.spacing) * 0.62
                    height: 34
                    color: btMouse.containsMouse
                        ? Qt.rgba(203 / 255, 166 / 255, 247 / 255, 0.14)
                        : Qt.rgba(1, 1, 1, 0.04)
                    border.width: 1
                    border.color: BarState.pillBorder

                    readonly property string btIcon: {
                        if (!BarState.btAvailable || !BarState.btEnabled) return "󰂲";
                        return BarState.btConnectedDevice ? "󰂱" : "󰂯";
                    }

                    readonly property string btLabel: {
                        if (!BarState.btAvailable) return "N/A";
                        if (!BarState.btEnabled) return "Off";
                        return BarState.btConnectedDevice || "On";
                    }

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 7

                        BarText {
                            height: parent.height
                            text: parent.parent.btIcon
                            font.pixelSize: 16
                            color: BarState.btEnabled ? BarState.accent : BarState.inactiveWorkspace
                        }

                        BarText {
                            width: parent.width - 23
                            height: parent.height
                            text: parent.parent.btLabel
                            font.pixelSize: 14
                            color: BarState.btEnabled ? BarState.textDefault : BarState.inactiveWorkspace
                            elide: Text.ElideRight
                        }
                    }

                    MouseArea {
                        id: btMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: BarState.btAvailable
                        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                        onClicked: BarState.toggleBluetooth()
                    }
                }

                Rectangle {
                    width: (parent.width - parent.spacing) * 0.38
                    height: 34
                    color: langMouse.containsMouse
                        ? Qt.rgba(203 / 255, 166 / 255, 247 / 255, 0.14)
                        : Qt.rgba(1, 1, 1, 0.04)
                    border.width: 1
                    border.color: BarState.pillBorder

                    BarText {
                        anchors.centerIn: parent
                        text: "󰇧 " + BarState.shortLanguage
                        font.pixelSize: 15
                        color: langMouse.containsMouse ? BarState.hoverColor : BarState.accent
                    }

                    MouseArea {
                        id: langMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: BarState.cycleLanguage()
                    }
                }
            }
        }
    }
}
