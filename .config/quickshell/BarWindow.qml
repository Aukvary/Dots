import QtQuick
import Quickshell
import Quickshell.Wayland
import "services"
import "modules"

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Auto

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        left: 2
        right: 2
    }

    implicitHeight: BarState.barHeight
    color: "transparent"

    Item {
        anchors.fill: parent
        anchors.leftMargin: 2
        anchors.rightMargin: 2

        Row {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            PowerMenuModule {
                id: powerMenu
                barWindow: root
            }

            Item {
                height: BarState.pillHeight
                clip: true
                width: powerMenu.popupOpen ? 0 : leftIndicatorsRow.implicitWidth
                opacity: powerMenu.popupOpen ? 0 : 1
                visible: width > 0

                Behavior on width {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }

                Row {
                    id: leftIndicatorsRow
                    height: parent.height
                    spacing: 4

                    AudioModule {}
                    BatteryModule {}
                    LanguageModule {}
                    NetworkModule {}
                }
            }
        }

        Row {
            anchors.centerIn: parent
            spacing: 4

            TimeDateModule {
                barWindow: root
            }
            MediaModule {
                barWindow: root
            }
        }

        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            TrayModule {
                barWindow: root
            }
            WorkspacesModule {
                barWindow: root
            }
        }
    }
}
