import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    property string value: "#000000"
    property var onChange: null
    property bool fullScreen: false
    property bool autoOpen: false
    property var onClose: null
    property string targetElement: ""
    property bool open: autoOpen
    
    color: "transparent"
    
    signal opened()
    signal closed()
    
    function show() { root.open = true; opened() }
    function hide() { root.open = false; if (onClose) onClose(); closed() }
    
    // Trigger button
    Rectangle {
        id: triggerBtn
        width: 28; height: 18
        radius: 4
        border.color: "#303340"
        border.width: 1
        color: root.value
        visible: !fullScreen
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.open = !root.open
        }
    }
    
    // Popover
    Rectangle {
        visible: root.open && !fullScreen
        width: 260; height: 380
        color: "#1a1c24"
        border.color: "#303340"
        border.width: 1
        radius: 8
        
        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10
            
            Text { text: root.targetElement; color: "#8b8fa8"; font.pixelSize: 11 }
            
            // Color wheel placeholder
            Rectangle {
                width: 220; height: 220
                radius: 110
                color: "#262830"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // Lightness slider
            Slider {
                width: 220
                from: 0; to: 100
                value: 50
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // Hex input
            TextField {
                width: 220
                text: root.value
                color: "#e8eaf0"
                background: Rectangle { color: "#13141a"; border.color: "#303340"; radius: 4 }
                anchors.horizontalCenter: parent.horizontalCenter
                onTextEdited: {
                    if (root.onChange) root.onChange(text)
                }
            }
        }
    }
    
    // Fullscreen overlay
    Rectangle {
        visible: root.open && fullScreen
        anchors.fill: parent
        color: "rgba(0,0,0,0.7)"
        
        Rectangle {
            width: 300; height: 400
            anchors.centerIn: parent
            color: "#1a1c24"
            border.color: "#303340"
            border.width: 1
            radius: 8
            
            Text {
                anchors.centerIn: parent
                text: "Color Picker"
                color: "#8b8fa8"
            }
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: root.hide()
        }
    }
}