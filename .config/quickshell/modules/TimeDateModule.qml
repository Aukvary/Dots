import QtQuick
import "../services"
import "../components"

PillContainer {
    id: root

    required property var barWindow

    horizontalPadding: 12

    property int viewYear: BarState.clock.date.getFullYear()
    property int viewMonth: BarState.clock.date.getMonth()

    readonly property var monthNames: [
        "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
        "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
    ]
    readonly property var weekdayNames: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]

    function resetToToday(): void {
        const now = BarState.clock.date;
        viewYear = now.getFullYear();
        viewMonth = now.getMonth();
    }

    function stepMonth(delta: int): void {
        const d = new Date(viewYear, viewMonth + delta, 1);
        viewYear = d.getFullYear();
        viewMonth = d.getMonth();
    }

    readonly property var calendarCells: {
        const now = BarState.clock.date;
        const todayY = now.getFullYear();
        const todayM = now.getMonth();
        const todayD = now.getDate();

        const firstOfMonth = new Date(root.viewYear, root.viewMonth, 1);
        // Convert JS getDay() (0=Sun..6=Sat) to Monday-first (0=Mon..6=Sun)
        const startOffset = (firstOfMonth.getDay() + 6) % 7;
        const daysInMonth = new Date(root.viewYear, root.viewMonth + 1, 0).getDate();
        const daysInPrevMonth = new Date(root.viewYear, root.viewMonth, 0).getDate();

        const cells = [];
        for (let i = 0; i < 42; i++) {
            const dayNum = i - startOffset + 1;
            let label = dayNum;
            let inCurrentMonth = true;
            let isToday = false;

            if (dayNum < 1) {
                label = daysInPrevMonth + dayNum;
                inCurrentMonth = false;
            } else if (dayNum > daysInMonth) {
                label = dayNum - daysInMonth;
                inCurrentMonth = false;
            } else {
                isToday = (root.viewYear === todayY && root.viewMonth === todayM && dayNum === todayD);
            }

            const isWeekend = (i % 7) >= 5;
            cells.push({
                day: label,
                inMonth: inCurrentMonth,
                today: isToday,
                weekend: isWeekend
            });
        }
        return cells;
    }

    BarText {
        anchors.verticalCenter: parent.verticalCenter
        text: "󰥔 " + BarState.timeText
        color: BarState.accent
    }

    HoverPopup {
        id: calPopup
        barWindow: root.barWindow
        anchorItem: root
        triggerHovered: root.hovered
        popupPadding: 14

        onOpenChanged: {
            if (open) root.resetToToday();
        }

        Column {
            spacing: 10
            width: 248

            // Current date banner
            Rectangle {
                width: parent.width
                height: dateBannerText.implicitHeight + 10
                color: Qt.rgba(203 / 255, 166 / 255, 247 / 255, 0.12)
                border.width: 1
                border.color: BarState.pillBorder

                BarText {
                    id: dateBannerText
                    anchors.centerIn: parent
                    text: "󰃭  " + Qt.formatDateTime(BarState.clock.date, "dd.MM.yyyy (ddd)")
                    font.pixelSize: 14
                    color: BarState.accent
                }
            }

            // Month navigation row
            Item {
                width: parent.width
                height: 24

                ModuleItem {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    height: 24
                    text: "‹"
                    fontSize: 18
                    horizontalPadding: 6
                    horizontalMargin: 0
                    baseColor: BarState.accent
                    hoverColor: BarState.hoverColor
                    onClicked: root.stepMonth(-1)
                }

                ModuleItem {
                    anchors.centerIn: parent
                    height: 24
                    text: root.monthNames[root.viewMonth] + " " + root.viewYear
                    fontSize: 14
                    horizontalPadding: 6
                    horizontalMargin: 0
                    baseColor: BarState.textDefault
                    hoverColor: BarState.accent
                    onClicked: root.resetToToday()
                }

                ModuleItem {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: 24
                    text: "›"
                    fontSize: 18
                    horizontalPadding: 6
                    horizontalMargin: 0
                    baseColor: BarState.accent
                    hoverColor: BarState.hoverColor
                    onClicked: root.stepMonth(1)
                }
            }

            // Weekday headers
            Grid {
                columns: 7
                columnSpacing: 2
                width: parent.width

                Repeater {
                    model: root.weekdayNames
                    delegate: Item {
                        required property string modelData
                        required property int index
                        width: 34
                        height: 22

                        BarText {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 12
                            color: index >= 5 ? BarState.accent : BarState.inactiveWorkspace
                        }
                    }
                }
            }

            // Days grid
            Grid {
                columns: 7
                columnSpacing: 2
                rowSpacing: 2
                width: parent.width

                Repeater {
                    model: root.calendarCells
                    delegate: Rectangle {
                        required property var modelData
                        width: 34
                        height: 28
                        color: modelData.today ? BarState.accent : "transparent"

                        BarText {
                            anchors.centerIn: parent
                            text: String(modelData.day)
                            font.pixelSize: 13
                            color: {
                                if (modelData.today) return "#181825";
                                if (!modelData.inMonth) return BarState.inactiveWorkspace;
                                return modelData.weekend ? BarState.hoverColor : BarState.textDefault;
                            }
                            opacity: modelData.inMonth || modelData.today ? 1.0 : 0.35
                        }
                    }
                }
            }
        }
    }
}
