import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    signal playPressed()
    signal pausePressed()
    signal skipBackPressed()
    signal skipForwardPressed()

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
                    onClicked: root.skipBackPressed()
                }
                RoundButton {
                    text: ">"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#4fc3f7"
                    font.pixelSize: 16
                    onClicked: root.playPressed()
                }
                RoundButton {
                    text: ">|"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#cccccc"
                    font.pixelSize: 14
                    onClicked: root.skipForwardPressed()
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