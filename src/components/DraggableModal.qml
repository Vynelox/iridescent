import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: ""
    property var body: null
    property var onClose: null
    property bool minimizable: true
    property bool isMinimized: false
    property var headerLeft: null
    property var style: ({})
    property real posX: 0
    property real posY: 0
    
    color: "transparent"
    
    Rectangle {
        width: 420
        height: root.isMinimized ? 36 : 300
        x: root.posX + parent.width / 2 - width / 2
        y: root.posY + parent.height / 2 - height / 2
        color: "#1a1c24"
        border.color: "#303340"
        border.width: 1
        radius: 10
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 0
            spacing: 0
            
            // Header
            Rectangle {
                Layout.fillWidth: true
                height: 36
                color: "#13141a"
                
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    
                    Text {
                        text: root.title
                        color: "#e8eaf0"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    Button {
                        text: root.isMinimized ? "□" : "−"
                        flat: true
                        palette.buttonText: "#8b8fa8"
                        visible: root.minimizable
                        onClicked: root.isMinimized = !root.isMinimized
                    }
                    
                    Button {
                        text: "×"
                        flat: true
                        palette.buttonText: "#8b8fa8"
                        onClicked: if (root.onClose) root.onClose()
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    property point dragOffset
                    onPressed: function(mouse) {
                        dragOffset.x = mouse.x
                        dragOffset.y = mouse.y
                    }
                    onPositionChanged: function(mouse) {
                        if (pressed) {
                            root.posX += mouse.x - dragOffset.x
                            root.posY += mouse.y - dragOffset.y
                        }
                    }
                }
            }
            
            // Body
            Loader {
                Layout.fillWidth: true
                Layout.fillHeight: true
                sourceComponent: root.body
                visible: !root.isMinimized
            }
        }
    }
}