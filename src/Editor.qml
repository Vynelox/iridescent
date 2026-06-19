import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: mainWindow
    width: 1280
    height: 720
    visible: true
    title: "Iridescent Video Editor"
    color: "#1e1e1e"

    property int playheadPosition: 120

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#1e1e1e"

        // ── Top Row: Media Pool + Viewer ──
        Rectangle {
            id: topRow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.6
            color: "#1e1e1e"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 6
                spacing: 0

                // ── Media Pool (Left) ──
                Rectangle {
                    id: mediaPool
                    Layout.fillHeight: true
                    width: 280
                    Layout.minimumWidth: 180
                    color: "#222222"
                    radius: 6

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 0

                        Rectangle {
                            Layout.fillWidth: true
                            height: 32
                            color: "#2a2a2a"
                            radius: 4

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Media Pool"
                                color: "#cccccc"
                                font.pixelSize: 12
                                font.family: "Segoe UI"
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: "0 items"
                                color: "#777777"
                                font.pixelSize: 11
                                font.family: "Segoe UI"
                            }
                        }

                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded

                            ColumnLayout {
                                width: mediaPool.width - 8
                                anchors.margins: 4
                                spacing: 4

                                Item {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    Text {
                                        anchors.centerIn: parent
                                        text: "Import media to get started"
                                        color: "#555555"
                                        font.pixelSize: 12
                                        font.family: "Segoe UI"
                                    }
                                }
                            }
                        }

                        Button {
                            Layout.fillWidth: true
                            Layout.margins: 6
                            text: "+ Import Media"
                            flat: true
                            palette.button: "#2e4a62"
                            palette.buttonText: "#4fc3f7"
                            font.pixelSize: 12
                            font.family: "Segoe UI"
                        }
                    }
                }

                // ── Vertical Splitter ──
                Rectangle {
                    id: vSplitter
                    width: 5
                    Layout.fillHeight: true
                    color: "#333333"

                    MouseArea {
                        id: vSplitterMouse
                        anchors.fill: parent
                        anchors.leftMargin: -4
                        anchors.rightMargin: -4
                        cursorShape: Qt.SizeHorCursor
                        property real dragStartMouseX: 0
                        property real dragStartWidth: 0

                        onPressed: function(mouse) {
                            dragStartMouseX = vSplitterMouse.mapToItem(topRow, mouse.x, mouse.y).x
                            dragStartWidth = mediaPool.width
                        }
                        onPositionChanged: function(mouse) {
                            if (pressedButtons === Qt.LeftButton) {
                                var currentX = vSplitterMouse.mapToItem(topRow, mouse.x, mouse.y).x
                                var delta = currentX - dragStartMouseX
                                var newWidth = dragStartWidth + delta
                                newWidth = Math.max(mediaPool.minimumWidth, Math.min(450, newWidth))
                                mediaPool.width = newWidth
                            }
                        }
                    }

                    Rectangle {
                        anchors.centerIn: parent
                        width: 2
                        height: 30
                        radius: 1
                        color: "#555555"
                    }
                }

                // ── Viewer (Right) ──
                Rectangle {
                    id: viewer
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#0a0a0a"
                    radius: 6

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 0

                        Rectangle {
                            Layout.fillWidth: true
                            height: 32
                            color: "#2a2a2a"
                            radius: 4

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Viewer"
                                color: "#cccccc"
                                font.pixelSize: 12
                                font.family: "Segoe UI"
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: "1920x1080  |  30fps"
                                color: "#777777"
                                font.pixelSize: 11
                                font.family: "Segoe UI"
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#0a0a0a"

                            Text {
                                anchors.centerIn: parent
                                text: "No media loaded"
                                color: "#555555"
                                font.pixelSize: 16
                                font.family: "Segoe UI"
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 40
                            color: "#222222"
                            radius: 4

                            RowLayout {
                                anchors.centerIn: parent
                                spacing: 8

                                RoundButton {
                                    text: "|<"
                                    flat: true
                                    palette.button: "transparent"
                                    palette.buttonText: "#cccccc"
                                    font.pixelSize: 14
                                }
                                RoundButton {
                                    text: ">"
                                    flat: true
                                    palette.button: "transparent"
                                    palette.buttonText: "#4fc3f7"
                                    font.pixelSize: 16
                                }
                                RoundButton {
                                    text: ">|"
                                    flat: true
                                    palette.button: "transparent"
                                    palette.buttonText: "#cccccc"
                                    font.pixelSize: 14
                                }

                                Rectangle {
                                    width: 1
                                    height: 20
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
                    }
                }
            }
        }

        // ── Horizontal Splitter ──
        Rectangle {
            id: hSplitter
            anchors.top: topRow.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 5
            color: "#333333"

            MouseArea {
                id: hSplitterMouse
                anchors.fill: parent
                anchors.topMargin: -4
                anchors.bottomMargin: -4
                cursorShape: Qt.SizeVerCursor
                property real dragStartMouseY: 0
                property real dragStartTopHeight: 0

                onPressed: function(mouse) {
                    dragStartMouseY = hSplitterMouse.mapToItem(root, mouse.x, mouse.y).y
                    dragStartTopHeight = topRow.height
                }
                onPositionChanged: function(mouse) {
                    if (pressedButtons === Qt.LeftButton) {
                        var currentY = hSplitterMouse.mapToItem(root, mouse.x, mouse.y).y
                        var delta = currentY - dragStartMouseY
                        var newHeight = dragStartTopHeight + delta
                        newHeight = Math.max(120, Math.min(root.height - 120, newHeight))
                        topRow.height = newHeight
                    }
                }
            }

            Rectangle {
                anchors.centerIn: parent
                width: 30
                height: 2
                radius: 1
                color: "#555555"
            }
        }

        // ── Timeline (Bottom) ──
        Rectangle {
            id: timeline
            anchors.top: hSplitter.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "#1a1a1a"
            radius: 0

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 0

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
                        }
                        RoundButton {
                            text: "+"
                            flat: true
                            palette.button: "transparent"
                            palette.buttonText: "#888888"
                            font.pixelSize: 16
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

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 0

                    Rectangle {
                        width: 120
                        Layout.fillHeight: true
                        color: "#1e1e1e"

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.topMargin: 0

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

                    // ── Tracks area with playhead ──
                    Rectangle {
                        id: tracksArea
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 1

                            // Time ruler with playhead
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
                                                    var totalSec = index * 2;
                                                    var m = Math.floor(totalSec / 60);
                                                    var s = totalSec % 60;
                                                    return String(m).padStart(2, '0') + ":" + String(s).padStart(2, '0');
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

                                // Playhead line on ruler
                                Rectangle {
                                    id: playheadRuler
                                    width: 2
                                    height: 24
                                    color: "#ff4444"
                                    x: mainWindow.playheadPosition
                                }
                            }

                            // Video track with playhead
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

                                // Playhead line on video track
                                Rectangle {
                                    width: 2
                                    height: 64
                                    color: "#ff4444"
                                    x: mainWindow.playheadPosition
                                }
                            }

                            // Audio track with playhead
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

                                // Playhead line on audio track
                                Rectangle {
                                    width: 2
                                    height: 64
                                    color: "#ff4444"
                                    x: mainWindow.playheadPosition
                                }
                            }
                        }

                        // Draggable playhead handle (overlay)
                        Rectangle {
                            id: playheadHandle
                            width: 16
                            height: ruler.height
                            x: mainWindow.playheadPosition - 7
                            y: 0
                            color: "transparent"

                            // Playhead triangle top
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
                                property real dragStartPos: 0

                                onPressed: function(mouse) {
                                    dragStartPos = mainWindow.playheadPosition
                                    var globalX = playheadMouseArea.mapToItem(tracksArea, mouse.x, mouse.y).x
                                    mainWindow.playheadPosition = Math.max(0, globalX)
                                }
                                onPositionChanged: function(mouse) {
                                    if (pressedButtons === Qt.LeftButton) {
                                        var globalX = playheadMouseArea.mapToItem(tracksArea, mouse.x, mouse.y).x
                                        mainWindow.playheadPosition = Math.max(0, globalX)
                                    }
                                }
                            }
                        }

                        // Timeline click/drag area (covers entire tracks area)
                        MouseArea {
                            anchors.fill: parent
                            anchors.topMargin: ruler.height
                            property bool isDragging: false

                            onPressed: function(mouse) {
                                isDragging = true
                                var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x
                                mainWindow.playheadPosition = Math.max(0, globalX)
                            }
                            onPositionChanged: function(mouse) {
                                if (isDragging && pressedButtons === Qt.LeftButton) {
                                    var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x
                                    mainWindow.playheadPosition = Math.max(0, globalX)
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
    }
}