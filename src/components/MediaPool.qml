import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    signal mediaSelected(string filePath)

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
                width: root.width - 8
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