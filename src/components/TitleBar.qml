import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    signal minimizeClicked()
    signal maximizeClicked()
    signal closeClicked()

    height: 32
    color: "#13141a"

    MouseArea {
        id: dragArea
        anchors.fill: parent
        property real lastX: 0
        property real lastY: 0

        onPressed: function(mouse) {
            lastX = mouse.x
            lastY = mouse.y
        }

        onPositionChanged: function(mouse) {
            if (pressedButtons === Qt.LeftButton) {
                var deltaX = mouse.x - lastX
                var deltaY = mouse.y - lastY
                mainWindow.x += deltaX
                mainWindow.y += deltaY
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 9

        // Application icon
        Image {
            source: "qrc:/iridescent.ico"
            sourceSize.width: 16
            sourceSize.height: 16
            fillMode: Image.PreserveAspectFit
        }

        // Title text
        Text {
            text: "Iridescent"
            color: "#8b8fa8"
            font.pixelSize: 11
            font.family: "Inter, Segoe UI"
            font.bold: true
            font.letterSpacing: 0.8
        }

        Rectangle { Layout.fillWidth: true }

        // Minimize button (orange)
        Rectangle {
            id: minimizeButton
            width: 12
            height: 12
            radius: 6
            color: minimizeButtonMouse.containsMouse ? "#fbbf24" : "#f59e0b"
            scale: minimizeButtonMouse.containsMouse ? 1.2 : 1.0

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            Behavior on scale {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }

            MouseArea {
                id: minimizeButtonMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.minimizeClicked()
            }
        }

        // Maximize button (green)
        Rectangle {
            id: maximizeButton
            width: 12
            height: 12
            radius: 6
            color: maximizeButtonMouse.containsMouse ? "#4ade80" : "#22c55e"
            scale: maximizeButtonMouse.containsMouse ? 1.2 : 1.0

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            Behavior on scale {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }

            MouseArea {
                id: maximizeButtonMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.maximizeClicked()
            }
        }

        // Close button (red)
        Rectangle {
            id: closeButton
            width: 12
            height: 12
            radius: 6
            color: closeButtonMouse.containsMouse ? "#f87171" : "#ef4444"
            scale: closeButtonMouse.containsMouse ? 1.2 : 1.0

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            Behavior on scale {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }

            MouseArea {
                id: closeButtonMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.closeClicked()
            }
        }
    }
}