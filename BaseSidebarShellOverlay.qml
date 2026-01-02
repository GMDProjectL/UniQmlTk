import QtQuick
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts
import org.kde.layershell 1.0 as LayerShell
import UniQmlTk

ApplicationWindow {
    id: root

    height: Screen.desktopAvailableHeight

    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    visible: true

    ThemeManager {
        id: themeManager
        targetWindow: root
        Component.onCompleted: initialize()
    }

    LayerShell.Window.anchors: LayerShell.Window.AnchorRight
    LayerShell.Window.layer: LayerShell.Window.LayerOverlay
    LayerShell.Window.exclusionZone: -1
    LayerShell.Window.keyboardInteractivity: LayerShell.Window.KeyboardInteractivityOnDemand

    Component.onCompleted: openAnimation()

    property string titleText: "Overlay"
    property string subtitleText: "to do smth productive"
    property alias mainContent: contentLoader.sourceComponent

    function openAnimation() {
        backgroundAnim.start()
        contentOpenAnim.start()
    }

    function closeAnimation() {
        closeAnim.start()
    }

    Rectangle {
        id: backgroundRect
        width: root.width
        height: root.height
        x: root.width
        color: Universal.background

        Rectangle {
            id: leftBorder
            width: 0
            opacity: 0
            anchors.left: parent.left
            height: parent.height
            color: Universal.accent
        }

        ParallelAnimation {
            id: backgroundAnim
            running: false

            NumberAnimation {
                target: backgroundRect
                property: "x"
                to: 0
                duration: 200
                easing.type: Easing.OutSine
            }

            NumberAnimation {
                target: backgroundRect
                property: "opacity"
                from: 0
                to: 1
                duration: 100
                easing.type: Easing.OutSine
            }

            NumberAnimation {
                target: subtitleLabel
                property: "leftPadding"
                to: 30
                duration: 500
                easing.type: Easing.OutSine
            }

            NumberAnimation {
                target: subtitleLabel
                property: "opacity"
                from: 0
                to: 0.45
                duration: 500
                easing.type: Easing.OutSine
            }

            NumberAnimation {
                target: leftBorder
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }
        }

    }

    Item {
        id: contentWrapper
        width: root.width
        height: root.height
        x: root.width
        opacity: 0

        ParallelAnimation {
            id: contentOpenAnim

            NumberAnimation {
                target: contentWrapper
                property: "x"
                to: 0
                duration: 300
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                target: contentWrapper
                property: "opacity"
                to: 1
                duration: 300
            }
        }

        ColumnLayout {
            id: contentColumn
            anchors.fill: parent
            anchors.margins: 24
            spacing: 0

            Label {
                text: root.titleText
                font.pointSize: 48
                font.weight: 300
                opacity: 0.8
                leftPadding: 20
            }

            Label {
                id: subtitleLabel
                leftPadding: 70
                text: root.subtitleText
                font.pointSize: 28
                font.weight: 300
                opacity: 0.45
            }

            Loader {
                id: contentLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: parent.width
            }
        }
    }

    ParallelAnimation {
        id: closeAnim

        NumberAnimation {
            target: backgroundRect
            property: "x"
            to: root.width
            duration: 250
            easing.type: Easing.InCubic
        }

        NumberAnimation {
            target: contentWrapper
            property: "x"
            to: root.width
            duration: 250
            easing.type: Easing.InCubic
        }

        NumberAnimation {
            target: contentWrapper
            property: "x"
            to: contentWrapper.width
            duration: 250
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            target: contentWrapper
            property: "opacity"
            to: 0
            duration: 250
        }

        NumberAnimation {
            target: leftBorder
            property: "opacity"
            from: 1
            to: 0
            duration: 100
        }

        onFinished: root.close()
    }
}
