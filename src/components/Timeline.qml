import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property int playheadPosition: 120

    signal playheadMoved(int position)
    signal zoomIn()
    signal zoomOut()

    color: "#1a1a1a"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0

        // Header
        Rectangle {
            Layout.fillWidth: true
            height: 32
            color: "#252525"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 12

                Text {
                    text: "Timeline"
                    color: "#cccccc"
                    font.pixelSize: 12
                    font.family: "Segoe UI"
                }

                Rectangle { Layout.fillWidth: true }

                RoundButton {
                    text: "-"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#888888"
                    font.pixelSize: 16
                    onClicked: root.zoomOut()
                }
                RoundButton {
                    text: "+"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#888888"
                    font.pixelSize: 16
                    onClicked: root.zoomIn()
                }

                Rectangle {
                    width: 1
                    height: 16
                    color: "#444444"
                }

                Text {
                    text: "00:00:00:00"
                    color: "#aaaaaa"
                    font.pixelSize: 12
                    font.family: "Consolas, monospace"
                }
            }
        }

        // Tracks area
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Track labels
            Rectangle {
                width: 120
                Layout.fillHeight: true
                color: "#1e1e1e"

                ColumnLayout {
                    anchors.fill: parent

                    Rectangle {
                        Layout.fillWidth: true
                        height: 24
                        color: "#252525"
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#222222"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            spacing: 6

                            Text {
                                text: "V1"
                                color: "#4fc3f7"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "Segoe UI"
                            }
                            Text {
                                text: "Video"
                                color: "#999999"
                                font.pixelSize: 11
                                font.family: "Segoe UI"
                            }
                            Rectangle { Layout.fillWidth: true }
                            Rectangle {
                                width: 8
                                height: 8
                                radius: 4
                                color: "#4fc3f7"
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#222222"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            spacing: 6

                            Text {
                                text: "A1"
                                color: "#81c784"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "Segoe UI"
                            }
                            Text {
                                text: "Audio"
                                color: "#999999"
                                font.pixelSize: 11
                                font.family: "Segoe UI"
                            }
                            Rectangle { Layout.fillWidth: true }
                            Rectangle {
                                width: 8
                                height: 8
                                radius: 4
                                color: "#81c784"
                            }
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

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 1

                    // Time ruler
                    Rectangle {
                        id: ruler
                        Layout.fillWidth: true
                        height: 24
                        color: "#2a2a2a"

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
                                        color: "#666666"
                                        font.pixelSize: 10
                                        font.family: "Consolas, monospace"
                                    }

                                    Rectangle {
                                        anchors.right: parent.right
                                        anchors.bottom: parent.bottom
                                        width: 1
                                        height: 8
                                        color: "#444444"
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: 2
                            height: 24
                            color: "#ff4444"
                            x: root.playheadPosition
                        }
                    }

                    // Video track
                    Rectangle {
                        Layout.fillWidth: true
                        height: 64
                        color: "#181818"

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 4
                            color: "transparent"
                            border.color: "#2a2a2a"
                            border.width: 1
                            radius: 2

                            Text {
                                anchors.centerIn: parent
                                text: "Drag video clips here"
                                color: "#444444"
                                font.pixelSize: 11
                                font.family: "Segoe UI"
                            }
                        }

                        Rectangle {
                            width: 2
                            height: 64
                            color: "#ff4444"
                            x: root.playheadPosition
                        }
                    }

                    // Audio track
                    Rectangle {
                        Layout.fillWidth: true
                        height: 64
                        color: "#181818"

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 4
                            color: "transparent"
                            border.color: "#2a2a2a"
                            border.width: 1
                            radius: 2

                            Text {
                                anchors.centerIn: parent
                                text: "Drag audio clips here"
                                color: "#444444"
                                font.pixelSize: 11
                                font.family: "Segoe UI"
                            }
                        }

                        Rectangle {
                            width: 2
                            height: 64
                            color: "#ff4444"
                            x: root.playheadPosition
                        }
                    }
                }

                // Playhead handle
                Rectangle {
                    id: playheadHandle
                    width: 16
                    height: ruler.height
                    x: root.playheadPosition - 7
                    y: 0
                    color: "transparent"

                    Rectangle {
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 12
                        height: 12
                        color: "#ff4444"
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