import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    signal playPressed()
    signal pausePressed()
    signal skipBackPressed()
    signal skipForwardPressed()

    color: "#060608"
    radius: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0

        // Header
        Rectangle {
            Layout.fillWidth: true
            height: 36
            color: "#13141a"
            radius: 0

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                text: "Viewer"
                color: "#8b8fa8"
                font.pixelSize: 11
                font.family: "Inter, Segoe UI"
                font.bold: true
                font.letterSpacing: 0.8
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                text: "1920x1080  |  30fps"
                color: "#4a4d5e"
                font.pixelSize: 10
                font.family: "Inter, Segoe UI"
            }
        }

        // Separator
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#262830"
        }

        // Viewer content
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#060608"

            Text {
                anchors.centerIn: parent
                text: "No media loaded"
                color: "#4a4d5e"
                font.pixelSize: 14
                font.family: "Inter, Segoe UI"
            }
        }

        // Transport controls
        Rectangle {
            Layout.fillWidth: true
            height: 36
            color: "#13141a"
            radius: 0

            RowLayout {
                anchors.centerIn: parent
                spacing: 6

                RoundButton {
                    text: "|<"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#8b8fa8"
                    font.pixelSize: 12
                    onClicked: root.skipBackPressed()
                }
                RoundButton {
                    text: ">"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#38bdf8"
                    font.pixelSize: 14
                    onClicked: root.playPressed()
                }
                RoundButton {
                    text: ">|"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#8b8fa8"
                    font.pixelSize: 12
                    onClicked: root.skipForwardPressed()
                }

                Rectangle {
                    width: 1
                    height: 16
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
    }
}