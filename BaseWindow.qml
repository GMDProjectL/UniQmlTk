import QtQuick
import QtQuick.Controls.Universal
import UniQmlTk

ApplicationWindow {
    id: root
    width: 640
    height: 480
    visible: true

    property alias mainContent: contentLoader.sourceComponent

    flags: Qt.Window | Qt.FramelessWindowHint

    ThemeManager {
        id: themeManager
        targetWindow: root
        Component.onCompleted: initialize()
    }

    Rectangle {
        id: titleBar
        anchors.top: parent.top
        width: parent.width
        height: 40
        color: Universal.background

        TapHandler {
            onTapped: if (tapCount === 2)
                          toggleMaximized()
            gesturePolicy: TapHandler.DragThreshold
        }

        DragHandler {
            target: titleBar
            grabPermissions: TapHandler.CanTakeOverFromAnything
            onActiveChanged: if (active) {
                                 root.startSystemMove()
                             }
        }
    }

    Row {
        anchors.right: parent.right
        spacing: 0

        Button {
            id: closeButton
            text: "✕"
            onClicked: root.close()
            leftPadding: 20
            rightPadding: 20
            background: Rectangle {
                color: closeButton.hovered ? "red" : Universal.background
            }
        }
    }

    function toggleMaximized() {
        if (root.visibility === Window.Maximized)
            root.showNormal()
        else
            root.showMaximized()
    }

    Loader {
        id: contentLoader
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
    }

    // Resize handles
    MouseArea {
        id: rightEdge
        width: 5
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeHorCursor
        onPressed: root.startSystemResize(Qt.RightEdge)
    }

    MouseArea {
        id: bottomEdge
        height: 5
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        cursorShape: Qt.SizeVerCursor
        onPressed: root.startSystemResize(Qt.BottomEdge)
    }

    MouseArea {
        id: bottomRightCorner
        width: 10
        height: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeFDiagCursor
        onPressed: root.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
    }

    MouseArea {
        id: leftEdge
        width: 5
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeHorCursor
        onPressed: root.startSystemResize(Qt.LeftEdge)
    }

    MouseArea {
        id: topEdge
        height: 5
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        cursorShape: Qt.SizeVerCursor
        onPressed: root.startSystemResize(Qt.TopEdge)
    }

    MouseArea {
        id: topLeftCorner
        width: 10
        height: 10
        anchors.left: parent.left
        anchors.top: parent.top
        cursorShape: Qt.SizeFDiagCursor
        onPressed: root.startSystemResize(Qt.LeftEdge | Qt.TopEdge)
    }

    MouseArea {
        id: topRightCorner
        width: 10
        height: 10
        anchors.right: parent.right
        anchors.top: parent.top
        cursorShape: Qt.SizeBDiagCursor
        onPressed: root.startSystemResize(Qt.RightEdge | Qt.TopEdge)
    }

    MouseArea {
        id: bottomLeftCorner
        width: 10
        height: 10
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeBDiagCursor
        onPressed: root.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)
    }
}
