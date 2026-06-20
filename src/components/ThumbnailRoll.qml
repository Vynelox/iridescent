import QtQuick

Row {
    id: root
    property string src: ""
    property int count: 6
    property var thumbnails: []
    spacing: 2
    
    Repeater {
        model: root.count
        Rectangle {
            width: root.width / root.count
            height: root.height
            color: "#111"
            
            Image {
                anchors.fill: parent
                source: root.thumbnails[index] || ""
                fillMode: Image.PreserveAspectCrop
                visible: root.thumbnails[index] !== undefined
            }
        }
    }
}