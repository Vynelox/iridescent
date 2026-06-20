import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property int playheadPosition: 120

    signal playheadMoved(int position)
    signal zoomIn()
    signal zoomOut()

    color: "#0c0d10"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0

        Rectangle {
            Layout.fillWidth: true
            height: 36
            color: "#13141a"
            radius: 0

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 10

                Text {
                    text: "Timeline"
                    color: "#8b8fa8"
                    font.pixelSize: 11
                    font.family: "Inter, Segoe UI"
                    font.bold: true
                    font.letterSpacing: 0.8
                }

                Rectangle { Layout.fillWidth: true }

                RoundButton {
                    text: "-"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#4a4d5e"
                    font.pixelSize: 14
                    onClicked: root.zoomOut()
                }
                RoundButton {
                    text: "+"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#4a4d5e"
                    font.pixelSize: 14
                    onClicked: root.zoomIn()
                }

                Rectangle {
                    width: 1
                    height: 14
                    color: "#262830"
                }

                Text {
                    text: "00:00:00:00"
                    color: "#8b8fa8"
                    font.pixelSize: 11
                    font.family: "JetBrains Mono, Consolas, monospace"
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#262830"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            Rectangle {
                width: 60
                Layout.fillHeight: true
                color: "#13141a"
                radius: 0

                ColumnLayout {
                    anchors.fill: parent

                    Rectangle {
                        Layout.fillWidth: true
                        height: 24
                        color: "#1a1c24"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#13141a"

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 5

                            Text {
                                text: "V1"
                                color: "#38bdf8"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "Inter, Segoe UI"
                            }
                            Rectangle {
                                width: 20
                                height: 18
                                color: "transparent"
                                Canvas {
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.strokeStyle = "#8b8fa8"
                                        ctx.lineWidth = 1.5
                                        ctx.strokeRect(2, 3, 14, 12)
                                        ctx.fillStyle = "#8b8fa8"
                                        ctx.fillRect(5, 1, 3, 3)
                                        ctx.fillRect(12, 1, 3, 3)
                                        ctx.fillRect(5, 14, 3, 3)
                                        ctx.fillRect(12, 14, 3, 3)
                                        ctx.beginPath()
                                        ctx.moveTo(2, 7)
                                        ctx.lineTo(16, 7)
                                        ctx.stroke()
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#13141a"

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 5

                            Text {
                                text: "A1"
                                color: "#34d399"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "Inter, Segoe UI"
                            }
                            Rectangle {
                                width: 20
                                height: 18
                                color: "transparent"
                                Canvas {
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.fillStyle = "#8b8fa8"
                                        ctx.strokeStyle = "#8b8fa8"
                                        ctx.lineWidth = 1.5
                                        ctx.beginPath()
                                        ctx.ellipse(4, 13, 4, 3, -0.3, 0, Math.PI * 2)
                                        ctx.fill()
                                        ctx.fillRect(7, 3, 1.5, 10)
                                        ctx.beginPath()
                                        ctx.ellipse(11, 10, 4, 3, -0.3, 0, Math.PI * 2)
                                        ctx.fill()
                                        ctx.fillRect(14, 2, 1.5, 8)
                                        ctx.beginPath()
                                        ctx.moveTo(8.5, 3)
                                        ctx.lineTo(15.5, 2)
                                        ctx.lineTo(15.5, 5)
                                        ctx.lineTo(8.5, 6)
                                        ctx.closePath()
                                        ctx.fill()
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: tracksArea
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                color: "#0c0d10"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        id: ruler
                        Layout.fillWidth: true
                        height: 24
                        color: "#1a1c24"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 4
                            spacing: 0

                            Repeater {
                                model: 50
                                delegate: Rectangle {
                                    width: 80
                                    height: 24
                                    color: "transparent"

                                    Text {
                                        anchors.left: parent.left
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 4
                                        text: {
                                            var totalSec = index * 2
                                            var m = Math.floor(totalSec / 60)
                                            var s = totalSec % 60
                                            return String(m).padStart(2, '0') + ":" + String(s).padStart(2, '0')
                                        }
                                        color: "#4a4d5e"
                                        font.pixelSize: 9
                                        font.family: "JetBrains Mono, Consolas, monospace"
                                    }

                                    Rectangle {
                                        anchors.right: parent.right
                                        anchors.bottom: parent.bottom
                                        width: 1
                                        height: 6
                                        color: "#262830"
                                    }
                                }
                            }
                        }

                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 56
                        color: "#0c0d10"

                        Canvas {
                            anchors.fill: parent
                            anchors.margins: 3
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.strokeStyle = "#1a1c24"
                                ctx.lineWidth = 1
                                var step = 20
                                for (var x = 0; x < width; x += step) {
                                    ctx.beginPath()
                                    ctx.moveTo(x, 0)
                                    ctx.lineTo(x, height)
                                    ctx.stroke()
                                }
                                for (var y = 0; y < height; y += step) {
                                    ctx.beginPath()
                                    ctx.moveTo(0, y)
                                    ctx.lineTo(width, y)
                                    ctx.stroke()
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 56
                        color: "#0c0d10"

                        Canvas {
                            anchors.fill: parent
                            anchors.margins: 3
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.strokeStyle = "#1a1c24"
                                ctx.lineWidth = 1
                                var step = 20
                                for (var x = 0; x < width; x += step) {
                                    ctx.beginPath()
                                    ctx.moveTo(x, 0)
                                    ctx.lineTo(x, height)
                                    ctx.stroke()
                                }
                                for (var y = 0; y < height; y += step) {
                                    ctx.beginPath()
                                    ctx.moveTo(0, y)
                                    ctx.lineTo(width, y)
                                    ctx.stroke()
                                }
                            }
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.topMargin: ruler.height
                    property bool isDragging: false

                    onPressed: function(mouse) {
                        isDragging = true
                        var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x
                        root.playheadPosition = Math.max(0, globalX)
                        root.playheadMoved(root.playheadPosition)
                    }
                    onPositionChanged: function(mouse) {
                        if (isDragging && pressedButtons === Qt.LeftButton) {
                            var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x
                            root.playheadPosition = Math.max(0, globalX)
                            root.playheadMoved(root.playheadPosition)
                        }
                    }
                    onReleased: function() {
                        isDragging = false
                    }
                }

                Rectangle {
                    id: playheadLine
                    width: 2
                    height: tracksArea.height
                    color: "#f87171"
                    x: root.playheadPosition
                }

                Rectangle {
                    id: playheadHandle
                    width: 14
                    height: tracksArea.height
                    x: root.playheadPosition - 6
                    y: 0
                    color: "transparent"

                    Rectangle {
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 10
                        height: 10
                        color: "#f87171"
                        rotation: 45
                        transformOrigin: Item.Center
                    }

                    MouseArea {
                        id: playheadMouseArea
                        anchors.fill: parent
                        anchors.leftMargin: -6
                        anchors.rightMargin: -6

                        onPressed: function(mouse) {
                            var globalX = playheadMouseArea.mapToItem(tracksArea, mouse.x, mouse.y).x
                            root.playheadPosition = Math.max(0, globalX)
                            root.playheadMoved(root.playheadPosition)
                        }
                        onPositionChanged: function(mouse) {
                            if (pressedButtons === Qt.LeftButton) {
                                var globalX = playheadMouseArea.mapToItem(tracksArea, mouse.x, mouse.y).x
                                root.playheadPosition = Math.max(0, globalX)
                                root.playheadMoved(root.playheadPosition)
                            }
                        }
                    }
                }
            }
        }
    }
}