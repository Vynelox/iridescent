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

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#1e1e1e"

        // ── Top Row: Viewer + Media Pool ──
        RowLayout {
            id: topRow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: timeline.top
            anchors.margins: 6
            spacing: 6

            // ── Viewer (Top-Left) ──
            Rectangle {
                id: viewer
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#0a0a0a"
                radius: 6

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 0

                    // Viewer header bar
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

                    // Viewer content area
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

                    // Transport controls
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

            // ── Media Pool (Top-Right) ──
            Rectangle {
                id: mediaPool
                Layout.fillHeight: true
                Layout.preferredWidth: 280
                Layout.minimumWidth: 220
                color: "#222222"
                radius: 6

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 0

                    // Media pool header
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

                    // Media pool content
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

                    // Import button
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
        }

        // ── Timeline (Bottom Half) ──
        Rectangle {
            id: timeline
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height * 0.45
            color: "#1a1a1a"
            radius: 0

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 0

                // Timeline header
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

                // Timeline ruler + tracks area
                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 0

                    // Track labels column
                    Rectangle {
                        width: 120
                        Layout.fillHeight: true
                        color: "#1e1e1e"

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.topMargin: 0

                            // Ruler spacer
                            Rectangle {
                                Layout.fillWidth: true
                                height: 24
                                color: "#252525"
                            }

                            // Video track label
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

                            // Audio track label
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

                    // Scrollable tracks area
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
                        ScrollBar.vertical.policy: ScrollBar.AsNeeded

                        ColumnLayout {
                            width: 2000
                            spacing: 1

                            // Time ruler
                            Rectangle {
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
                            }
                        }
                    }
                }
            }
        }
    }
}