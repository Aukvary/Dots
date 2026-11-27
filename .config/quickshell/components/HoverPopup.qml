import QtQuick
import Quickshell
import "../services"

PopupWindow {
    id: root

    required property var barWindow
    required property Item anchorItem
    required property bool triggerHovered

    default property alias content: container.data
    property int popupPadding: 12
    property bool forceOpen: false

    readonly property bool open: triggerHovered || popupHover.hovered || forceOpen || closeDelay.running

    onTriggerHoveredChanged: {
        if (!triggerHovered && !popupHover.hovered && !forceOpen) {
            closeDelay.restart();
        } else {
            closeDelay.stop();
        }
    }

    onForceOpenChanged: {
        if (!forceOpen && !triggerHovered && !popupHover.hovered) {
            closeDelay.restart();
        } else if (forceOpen) {
            closeDelay.stop();
        }
    }

    Connections {
        target: popupHover
        function onHoveredChanged() {
            if (!popupHover.hovered && !root.triggerHovered && !root.forceOpen) {
                closeDelay.restart();
            } else {
                closeDelay.stop();
            }
        }
    }

    Timer {
        id: closeDelay
        interval: 150
        repeat: false
    }

    visible: open
    anchor.window: root.barWindow
    anchor.item: root.anchorItem
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    anchor.margins.top: 4
    color: "transparent"

    implicitWidth: frame.implicitWidth
    implicitHeight: frame.implicitHeight

    Rectangle {
        id: frame
        color: BarState.popupBg
        border.width: 1
        border.color: BarState.pillBorder
        implicitWidth: container.implicitWidth + (root.popupPadding * 2)
        implicitHeight: container.implicitHeight + (root.popupPadding * 2)

        HoverHandler {
            id: popupHover
        }

        Item {
            id: container
            anchors.centerIn: parent
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
        }
    }
}
