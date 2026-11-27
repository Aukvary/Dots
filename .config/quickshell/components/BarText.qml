import QtQuick
import "../services"

Text {
    font.family: BarState.fontFamily
    font.pixelSize: BarState.fontSize
    font.weight: Font.Black
    color: BarState.textDefault
    verticalAlignment: Text.AlignVCenter
    renderType: Text.NativeRendering
}
