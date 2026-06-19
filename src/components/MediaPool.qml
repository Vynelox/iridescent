import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    signal mediaSelected(string filePath)

    color: "#13141a"
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
                text: "Media Pool"
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
                text: "0 items"
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

        // Content
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AsNeeded

            ColumnLayout {
                width: root.width - 8
                anchors.margins: 6
                spacing: 4

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Rectangle {
                        anchors.fill: parent
                        anchors.topMargin: 8
                        color: "#13141a"
                        border.color: "#303340"
                        border.width: 1
                        radius: 4

                        Text {
                            anchors.centerIn: parent
                            text: "Drop media here or click to import"
                            color: "#4a4d5e"
                            font.pixelSize: 11
                            font.family: "Inter, Segoe UI"
                        }
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
            palette.button: "#1a1c24"
            palette.buttonText: "#38bdf8"
            font.pixelSize: 11
            font.family: "Inter, Segoe UI"
        }
    }
}