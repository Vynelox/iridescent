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

        // Header
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

        // Separator
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#262830"
        }

        // Tracks area
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Track labels
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
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            spacing: 4

                            Text {
                                text: "V1"
                                color: "#38bdf8"
                                font.pixelSize: 10
                                font.bold: true
                                font.family: "Inter, Segoe UI"
                            }
                            Rectangle {
                                width: 14
                                height: 12
                                color: "transparent"
                                Canvas {
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.strokeStyle = "#8b8fa8"
                                        ctx.lineWidth = 1
                                        ctx.strokeRect(1, 1, 8, 10)
                                        ctx.fillRect(2, 0, 2, 2)
                                        ctx.fillRect(2, 10, 2, 2)
                                        ctx.fillRect(10, 0, 2, 2)
                                        ctx.fillRect(10, 10, 2, 2)
                                        ctx.strokeRect(3, 3, 4, 6)
                                    }
                                }
                            }
                            Rectangle { Layout.fillWidth: true }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#13141a"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            spacing: 4

                            Text {
                                text: "A1"
                                color: "#34d399"
                                font.pixelSize: 10
                                font.bold: true
                                font.family: "Inter, Segoe UI"
                            }
                            Rectangle {
                                width: 14
                                height: 12
                                color: "transparent"
                                Canvas {
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.strokeStyle = "#8b8fa8"
                                        ctx.fillStyle = "#8b8fa8"
                                        ctx.lineWidth = 1
                                        ctx.beginPath()
                                        ctx.moveTo(1, 4)
                                        ctx.lineTo(4, 4)
                                        ctx.lineTo(7, 1)
                                        ctx.lineTo(7, 11)
                                        ctx.lineTo(4, 8)
                                        ctx.lineTo(1, 8)
                                        ctx.closePath()
                                        ctx.fill()
                                        ctx.beginPath()
                                        ctx.arc(9, 6, 2, -0.5, 0.5)
                                        ctx.stroke()
                                        ctx.beginPath()
                                        ctx.arc(9, 6, 4, -0.5, 0.5)
                                        ctx.stroke()
                                    }
                                }
                            }
                            Rectangle { Layout.fillWidth: true }
                        }
                    }
                }
            }

            // Tracks content with playhead
            Rectangle {
                id: tracksArea
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                color: "#0c0d10"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 1

                    // Time ruler
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

                        Rectangle {
                            width: 2
                            height: 24
                            color: "#f87171"
                            x: root.playheadPosition
                        }
                    }

                    // Video track
                    Rectangle {
                        Layout.fillWidth: true
                        height: 56
                        color: "#0c0d10"

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 3
                            color: "transparent"
                            border.color: "#1a1c24"
                            border.width: 1
                            radius: 3

                            Text {
                                anchors.centerIn: parent
                                text: "Drag video clips here"
                                color: "#303340"
                                font.pixelSize: 10
                                font.family: "Inter, Segoe UI"
                            }
                        }

                        Rectangle {
                            width: 2
                            height: 56
                            color: "#f87171"
                            x: root.playheadPosition
                        }
                    }

                    // Audio track
                    Rectangle {
                        Layout.fillWidth: true
                        height: 56
                        color: "#0c0d10"

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 3
                            color: "transparent"
                            border.color: "#1a1c24"
                            border.width: 1
                            radius: 3

                            Text {
                                anchors.centerIn: parent
                                text: "Drag audio clips here"
                                color: "#303340"
                                font.pixelSize: 10
                                font.family: "Inter, Segoe UI"
                            }
                        }

                        Rectangle {
                            width: 2
                            height: 56
                            color: "#f87171"
                            x: root.playheadPosition
                        }
                    }
                }

                // Playhead handle
                Rectangle {
                    id: playheadHandle
                    width: 14
                    height: ruler.height
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

                // Timeline click/drag area
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
            }
        }
    }
}