import QtQuick

Item {
    id: root
    property var pos: ({ x: 0, y: 0 })
    property var target: null
    property var onClose: null
    property var onSplit: null
    property var onTrimLatter: null
    property var onTrimFormer: null
    property var onStep: null
    property var onRoll: null
    property bool interactive: false
    property int bounce: 60
    property int speed: 250
    property int smoothness: 50
    property string animType: "pop"
    property bool closeOnBackgroundClick: true
    
    visible: pos !== null
    
    x: pos ? pos.x - 120 : 0
    y: pos ? pos.y - 120 : 0
    width: 240; height: 240
    
    // Background overlay
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.closeOnBackgroundClick && root.onClose) root.onClose()
            }
        }
    }
    
    // Center close button
    Rectangle {
        width: 36; height: 36
        radius: 18
        anchors.centerIn: parent
        color: "#1a1c24"
        border.color: "#38bdf8"
        border.width: 2
        
        Text {
            anchors.centerIn: parent
            text: "×"
            color: "#38bdf8"
            font.pixelSize: 16
            font.bold: true
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: if (root.onClose) root.onClose()
        }
    }
    
    // Menu items
    Repeater {
        model: root.target && root.target.kind === "edge"
            ? ["Step +1f", "Step −1f", "Ripple +1f", "Ripple −1f"]
            : ["Split", "Trim →", "Trim ←", "Ripple →", "Ripple ←", "Roll"]
        
        Rectangle {
            width: 64; height: 56
            radius: 6
            color: "#141620"
            border.color: "rgba(255,255,255,0.06)"
            border.width: 1
            
            property real angle: (index / 6) * 2 * Math.PI - Math.PI / 2
            property real itemR: 78
            x: 120 + Math.cos(angle) * itemR - 32
            y: 120 + Math.sin(angle) * itemR - 28
            
            Text {
                anchors.centerIn: parent
                text: modelData
                color: "#e8eaf0"
                font.pixelSize: 9
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                width: parent.width - 8
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (index === 0 && root.onSplit) root.onSplit()
                    else if (index === 1 && root.onTrimLatter) root.onTrimLatter(false)
                    else if (index === 2 && root.onTrimFormer) root.onTrimFormer(false)
                    else if (index === 3 && root.onTrimLatter) root.onTrimLatter(true)
                    else if (index === 4 && root.onTrimFormer) root.onTrimFormer(true)
                    else if (index === 5 && root.onRoll) root.onRoll()
                    if (root.onClose) root.onClose()
                }
            }
        }
    }
}