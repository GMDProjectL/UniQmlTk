import QtQuick
import QtQuick.Controls.Universal

ItemDelegate {
    id: control

    property bool activeAndHighlighted: false

    signal doubleClicked()

    scale: mouseArea.pressed ? 0.985 : 1

    Behavior on scale {
        NumberAnimation {
            duration: 80
            easing.type: Easing.OutBack
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: control.clicked()
        onDoubleClicked: control.doubleClicked()
    }

    background: SelectableBackground {
        isPressed: mouseArea.pressed
        isHighlighted: control.activeAndHighlighted
        isHovered: control.hovered
    }
}
