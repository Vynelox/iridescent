import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string clipName: ""
    property var onClose: null
    property var onApply: null
    property int srcIn: 0
    property int duration: 0
    property int maxSrcOut: 0
    
    color: "transparent"
    
    Rectangle {
        width: 420; height: 300
        color: "#1a1c24"
        border.color: "#303340"
        border.width: 1
        radius: 10
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10
            
            Text {
                text: "Roll Edit — " + root.clipName
                color: "#e8eaf0"
                font.pixelSize: 14
                font.bold: true
            }
            
            Text {
                text: "Adjust which part of the source is used. Timeline in/out points stay fixed."
                color: "#8b8fa8"
                font.pixelSize: 12
                wrapMode: Text.Wrap
                Layout.fillWidth: true
            }
            
            Text { text: "Source In"; color: "#8b8fa8"; font.pixelSize: 12 }
            Slider {
                Layout.fillWidth: true
                from: 0; to: Math.max(0, root.maxSrcOut - root.duration)
                value: root.srcIn
            }
            
            RowLayout {
                Layout.fillWidth: true
                Button {
                    text: "Cancel"
                    flat: true
                    palette.buttonText: "#8b8fa8"
                    onClicked: if (root.onClose) root.onClose()
                }
                Item { Layout.fillWidth: true }
                Button {
                    text: "Apply"
                    flat: true
                    palette.buttonText: "#38bdf8"
                    onClicked: {
                        if (root.onApply) root.onApply(root.srcIn, root.srcIn + root.duration)
                        if (root.onClose) root.onClose()
                    }
                }
            }
        }
    }
}