import QtQuick
import QtQuick.Layouts

Rectangle {
    id: tog
    property bool   active:   false
    property bool   dimmed:   false
    property string label:    ""
    property string iconSvg:  ""
    signal toggled()

    implicitHeight: 56
    radius: 8
    color: active ? "#313244" : "#181825"

    Behavior on color { ColorAnimation { duration: 100 } }

    Column {
        anchors.centerIn: parent
        spacing: 5

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 18; height: 18; smooth: true
            source: {
                var stroke = tog.active ? "%23cba6f7"
                           : tog.dimmed ? "%2345475a"
                           : "%23585b70"
                return tog.iconSvg.replace("currentColor", stroke)
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: tog.label
            color: tog.active ? "#cdd6f4" : "#585b70"
            font.family: "Google Sans"; font.pixelSize: 10
            elide: Text.ElideRight; width: tog.width - 8
            horizontalAlignment: Text.AlignHCenter
            Behavior on color { ColorAnimation { duration: 100 } }
        }
    }

    MouseArea {
        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
        onClicked: tog.toggled()
    }
}
