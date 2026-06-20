import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property var onClose: null
    color: "transparent"
    
    Rectangle {
        width: 360; height: 400
        color: "#1a1c24"
        border.color: "#303340"
        border.width: 1
        radius: 10
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10
            
            Text {
                text: "Torus Menu Editor"
                color: "#e8eaf0"
                font.pixelSize: 14
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }
            
            Button {
                text: "Toggle Preview"
                Layout.alignment: Qt.AlignHCenter
                flat: true
                palette.buttonText: "#38bdf8"
            }
            
            Text {
                text: "Animation type"
                color: "#8b8fa8"
                font.pixelSize: 13
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: 6
                Repeater {
                    model: ["none", "pop", "clock"]
                    Button {
                        text: modelData.charAt(0).toUpperCase() + modelData.slice(1)
                        flat: true
                        palette.buttonText: "#8b8fa8"
                        font.pixelSize: 12
                    }
                }
            }
            
            Text { text: "Bounce"; color: "#8b8fa8"; font.pixelSize: 13 }
            Slider { Layout.fillWidth: true; from: 0; to: 100; value: 60 }
            
            Text { text: "Speed"; color: "#8b8fa8"; font.pixelSize: 13 }
            Slider { Layout.fillWidth: true; from: 50; to: 500; value: 250 }
            
            Text { text: "Smoothness"; color: "#8b8fa8"; font.pixelSize: 13 }
            Slider { Layout.fillWidth: true; from: 0; to: 100; value: 50 }
            
            Item { Layout.fillHeight: true }
            
            Button {
                text: "Close"
                Layout.alignment: Qt.AlignHCenter
                flat: true
                palette.buttonText: "#8b8fa8"
                onClicked: if (root.onClose) root.onClose()
            }
        }
    }
}