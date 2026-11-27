import QtQuick
import Quickshell.Services.Mpris
import "../services"
import "../components"

PillContainer {
    id: root

    required property var barWindow

    horizontalPadding: 6

    property real displayPos: 0
    property real trackLen: 0

    function syncProgress(): void {
        const p = BarState.activePlayer;
        if (!p) {
            displayPos = 0;
            trackLen = 0;
            return;
        }
        trackLen = p.lengthSupported && p.length > 0 ? p.length : 0;
        displayPos = p.positionSupported && p.position >= 0 ? p.position : 0;
    }

    onVisibleChanged: syncProgress()

    Connections {
        target: BarState
        function onActivePlayerChanged() {
            root.syncProgress();
        }
    }

    Connections {
        target: BarState.activePlayer
        function onPositionChanged() {
            root.syncProgress();
        }
        function onLengthChanged() {
            root.syncProgress();
        }
        function onTrackTitleChanged() {
            root.syncProgress();
        }
    }

    Timer {
        interval: 250
        repeat: true
        running: mediaPopup.open && BarState.activePlayer !== null
        onTriggered: {
            if (BarState.activePlayer && BarState.activePlayer.positionSupported) {
                BarState.activePlayer.positionChanged();
            }
            root.syncProgress();
        }
    }

    BarText {
        anchors.verticalCenter: parent.verticalCenter
        text: "󰎈 " + BarState.mediaTitle
        color: BarState.accent
        leftPadding: 3
        rightPadding: 3
    }

    HoverPopup {
        id: mediaPopup
        barWindow: root.barWindow
        anchorItem: root
        triggerHovered: root.hovered
        popupPadding: 14
        forceOpen: seekMouse.pressed

        onOpenChanged: {
            if (open) root.syncProgress();
        }

        Column {
            spacing: 10
            width: 340

            Row {
                spacing: 12
                width: parent.width

                // Album cover
                Rectangle {
                    width: 84
                    height: 84
                    color: Qt.rgba(1, 1, 1, 0.05)
                    border.width: 1
                    border.color: BarState.pillBorder
                    clip: true

                    Image {
                        id: coverImg
                        anchors.fill: parent
                        anchors.margins: 1
                        source: BarState.mediaArtUrl
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        visible: status === Image.Ready
                    }

                    BarText {
                        anchors.centerIn: parent
                        visible: !coverImg.visible
                        text: "󰎈"
                        font.pixelSize: 28
                        color: BarState.accent
                    }
                }

                // Track info & controls
                Column {
                    width: parent.width - 84 - 12
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 4

                    BarText {
                        width: parent.width
                        text: BarState.mediaFullTitle
                        font.pixelSize: 15
                        color: BarState.accent
                        elide: Text.ElideRight
                    }

                    BarText {
                        width: parent.width
                        text: "󰗋 " + BarState.mediaFullArtist
                        font.pixelSize: 13
                        color: BarState.textDefault
                        elide: Text.ElideRight
                    }

                    Row {
                        spacing: 6
                        topPadding: 4
                        visible: BarState.activePlayer !== null

                        ModuleItem {
                            height: 26
                            text: "⏮"
                            fontSize: BarState.iconFontSize
                            horizontalPadding: 8
                            horizontalMargin: 0
                            baseColor: BarState.accent
                            hoverColor: BarState.hoverColor
                            onClicked: {
                                if (BarState.activePlayer) BarState.activePlayer.previous();
                            }
                        }

                        ModuleItem {
                            height: 26
                            text: BarState.mediaStatusIcon
                            fontSize: BarState.iconFontSize
                            horizontalPadding: 8
                            horizontalMargin: 0
                            baseColor: BarState.accent
                            hoverColor: BarState.hoverColor
                            onClicked: {
                                if (BarState.activePlayer) BarState.activePlayer.togglePlaying();
                            }
                        }

                        ModuleItem {
                            height: 26
                            text: "⏭"
                            fontSize: BarState.iconFontSize
                            horizontalPadding: 8
                            horizontalMargin: 0
                            baseColor: BarState.accent
                            hoverColor: BarState.hoverColor
                            onClicked: {
                                if (BarState.activePlayer) BarState.activePlayer.next();
                            }
                        }
                    }
                }
            }

            // Progress bar & elapsed / total timer
            Column {
                width: parent.width
                spacing: 6
                visible: BarState.activePlayer !== null

                Rectangle {
                    id: progressTrough
                    width: parent.width
                    height: 8
                    color: BarState.sliderTrough

                    readonly property real ratio: root.trackLen > 0
                        ? Math.max(0, Math.min(1.0, root.displayPos / root.trackLen))
                        : 0

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: progressTrough.ratio * parent.width
                        color: BarState.accent
                    }

                    MouseArea {
                        id: seekMouse
                        anchors.fill: parent
                        anchors.topMargin: -6
                        anchors.bottomMargin: -6
                        enabled: BarState.activePlayer !== null && BarState.activePlayer.canSeek && root.trackLen > 0
                        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

                        function seekAt(mx) {
                            const r = Math.max(0, Math.min(1.0, mx / progressTrough.width));
                            BarState.activePlayer.position = r * root.trackLen;
                            root.displayPos = r * root.trackLen;
                        }

                        onPressed: mouse => seekAt(mouse.x)
                        onPositionChanged: mouse => {
                            if (pressed) seekAt(mouse.x);
                        }
                    }
                }

                Item {
                    width: parent.width
                    height: elapsedLabel.implicitHeight

                    BarText {
                        id: elapsedLabel
                        anchors.left: parent.left
                        text: BarState.formatDuration(root.displayPos)
                        font.pixelSize: 12
                        color: BarState.textDefault
                    }

                    BarText {
                        anchors.right: parent.right
                        text: root.trackLen > 0 ? BarState.formatDuration(root.trackLen) : "--:--"
                        font.pixelSize: 12
                        color: BarState.inactiveWorkspace
                    }
                }
            }
        }
    }
}
