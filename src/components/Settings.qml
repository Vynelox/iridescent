import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property var onClose: null
    color: "transparent"
    
    signal settingChanged(string key, var value)
    
    function resetAll() { }
    function resetSetting(key) { }
    
    Rectangle {
        width: 480; height: 400
        color: "#1a1c24"
        border.color: "#303340"
        border.width: 1
        radius: 10
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 0
            
            // Header
            Rectangle {
                Layout.fillWidth: true
                height: 36
                color: "#13141a"
                
                Text {
                    anchors.centerIn: parent
                    text: "Settings"
                    color: "#e8eaf0"
                    font.pixelSize: 14
                    font.bold: true
                }
                
                Button {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "×"
                    flat: true
                    palette.buttonText: "#8b8fa8"
                    onClicked: if (root.onClose) root.onClose()
                }
            }
            
            // Tabs
            RowLayout {
                Layout.fillWidth: true
                Layout.margins: 8
                spacing: 4
                
                Repeater {
                    model: ["Keyboard", "Sliders", "Checkboxes", "Multiselects", "Components"]
                    Button {
                        text: modelData
                        flat: true
                        palette.buttonText: "#8b8fa8"
                        font.pixelSize: 12
                    }
                }
            }
            
            // Content
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                Text {
                    text: "Settings content"
                    color: "#4a4d5e"
                    anchors.centerIn: parent
                }
            }
        }
    }
}