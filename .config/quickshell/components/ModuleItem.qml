import QtQuick
import "../services"

Item {
    id: root

    property string text: ""
    property color baseColor: BarState.accent
    property color hoverColor: BarState.hoverColor
    property int fontSize: BarState.fontSize
    property int horizontalPadding: 2
    property int horizontalMargin: 1
    property bool clickable: true

    signal clicked(var mouse)
    signal wheeled(var wheel)

    readonly property bool hovered: mouseArea.containsMouse

    height: parent ? parent.height : BarState.pillHeight
    implicitWidth: label.implicitWidth + (horizontalPadding + horizontalMargin) * 2

    BarText {
        id: label
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: root.fontSize
        color: root.clickable && root.hovered ? root.hoverColor : root.baseColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: root.clickable
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: mouse => {
            if (root.clickable) root.clicked(mouse);
        }
        onWheel: wheel => root.wheeled(wheel)
    }
}
