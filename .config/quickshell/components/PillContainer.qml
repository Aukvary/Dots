import QtQuick
import "../services"

Rectangle {
    id: root

    property int horizontalPadding: 6
    default property alias content: innerRow.data
    property alias spacing: innerRow.spacing
    readonly property bool hovered: pillHoverHandler.hovered

    signal wheeled(var wheel)

    color: BarState.pillBg
    border.width: 1
    border.color: BarState.pillBorder
    height: BarState.pillHeight
    implicitWidth: innerRow.implicitWidth + (horizontalPadding * 2)

    HoverHandler {
        id: pillHoverHandler
    }

    WheelHandler {
        onWheel: event => root.wheeled(event)
    }

    Row {
        id: innerRow
        anchors.centerIn: parent
        height: parent.height
        spacing: 0
    }
}
