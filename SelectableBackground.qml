import QtQuick
import QtQuick.Controls.Universal

Rectangle {
    property bool isPressed: false
    property bool isHighlighted: false
    property bool isHovered: false

    color: isPressed ? Universal.baseMediumColor
        : (!isHighlighted
            ? (isHovered ? Universal.baseLowColor : Universal.background)
            : Universal.accent)

    border.color: isHighlighted ? Qt.lighter(Universal.accent) : "transparent"
    border.width: 1
}
