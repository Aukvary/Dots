import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../components"

PillContainer {
    id: root

    required property var barWindow

    horizontalPadding: 12
    spacing: 10
    visible: trayRepeater.count > 0

    Repeater {
        id: trayRepeater
        model: SystemTray.items

        delegate: Item {
            id: trayItem
            required property SystemTrayItem modelData

            width: 16
            height: root.height

            IconImage {
                anchors.centerIn: parent
                implicitSize: 16
                source: trayItem.modelData.icon
                asynchronous: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor

                function openTrayMenu() {
                    if (!trayItem.modelData.hasMenu) return;
                    const pos = trayItem.mapToItem(null, 0, trayItem.height);
                    trayItem.modelData.display(root.barWindow, Math.round(pos.x), Math.round(pos.y));
                }

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        if (trayItem.modelData.onlyMenu) {
                            openTrayMenu();
                        } else {
                            trayItem.modelData.activate();
                        }
                    } else if (mouse.button === Qt.MiddleButton) {
                        trayItem.modelData.secondaryActivate();
                    } else if (mouse.button === Qt.RightButton) {
                        openTrayMenu();
                    }
                }

                onWheel: wheel => {
                    if (wheel.angleDelta.y !== 0) {
                        trayItem.modelData.scroll(wheel.angleDelta.y, false);
                    } else if (wheel.angleDelta.x !== 0) {
                        trayItem.modelData.scroll(wheel.angleDelta.x, true);
                    }
                }
            }
        }
    }
}
