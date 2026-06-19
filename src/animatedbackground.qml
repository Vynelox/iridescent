import QtQuick

Window {
    id: root
    width: 800
    height: 600
    visible: true
    title: "Iridescent Pattern"
    color: "white" // This sets the actual window background

    property real angle: 0

    NumberAnimation on angle {
        from: 0
        to: 360
        duration: 6000
        loops: Animation.Infinite
        running: true
    }

    Repeater {
        model: 8
        Rectangle {
            width: 40
            height: 40
            radius: 8
            color: Qt.rgba(0.2 + (index % 3) * 0.2, 0.4 + (index % 4) * 0.15, 0.8, 0.35)
            x: root.width / 2 + Math.cos((angle + index * 45) * Math.PI / 180) * (120 + index * 20) - 20
            y: root.height / 2 + Math.sin((angle + index * 45) * Math.PI / 180) * (120 + index * 20) - 20
            rotation: angle * (1 + index * 0.3)
        }
    }

    Repeater {
        model: 12
        Rectangle {
            width: 20
            height: 20
            radius: 10
            color: Qt.rgba(0.8, 0.3 + (index % 3) * 0.2, 0.2 + (index % 5) * 0.15, 0.3)
            x: root.width / 2 + Math.cos((-angle * 0.7 + index * 30) * Math.PI / 180) * (200 + index * 15) - 10
            y: root.height / 2 + Math.sin((-angle * 0.7 + index * 30) * Math.PI / 180) * (200 + index * 15) - 10
            rotation: -angle * (1.5 + index * 0.2)
        }
    }
}