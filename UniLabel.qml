import QtQuick 2.15
import QtQuick.Controls.Universal

Label {
    id: root
    property int animDelay: 0
    property int animDuration: 0

    opacity: 0
    x: 100

    transform: Rotation {
        id: rotation
        // pivot at left edge, vertically centered
        origin.x: 0
        origin.y: root.height / 2
        axis {
            x: 0
            y: 1
            z: 0
        }
        angle: 20
    }

    Component.onCompleted: anim.start()

    SequentialAnimation {
        id: anim

        PauseAnimation {
            duration: root.animDelay
        }

        ParallelAnimation {
            NumberAnimation {
                target: root
                property: "opacity"
                from: 0
                to: 1
                duration: root.animDuration
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                target: rotation
                property: "angle"
                from: 10
                to: 0
                duration: root.animDuration
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                target: root
                property: "x"
                from: 100
                to: 0
                duration: root.animDuration
                easing.type: Easing.OutCubic
            }
        }
    }
}
