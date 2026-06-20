import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    property string label: "None"
    property bool editing: false
    property int index: 0
    property var onRemove: null
    property var onKeyInput: null
    
    height: 28
    radius: 4
    color: editing ? "#21242f" : "#1a1c24"
    border.color: editing ? "#38bdf8" : "#303340"
    border.width: 1
    
    Row {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 4
        spacing: 4
        
        Text {
            text: root.editing && root.label === "None" ? "..." : root.label
            color: root.label !== "None" ? "#e8eaf0" : "#4a4d5e"
            font.pixelSize: 12
            font.family: "JetBrains Mono, monospace"
            anchors.verticalCenter: parent.verticalCenter
        }
        
        Button {
            text: "×"
            flat: true
            palette.buttonText: "#4a4d5e"
            font.pixelSize: 13
            anchors.verticalCenter: parent.verticalCenter
            visible: true
            onClicked: if (root.onRemove) root.onRemove(root.index)
        }
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: root.editing = true
    }
    
    Keys.onPressed: function(event) {
        if (root.editing && root.onKeyInput) {
            root.onKeyInput(root.index, event.key, event.modifiers)
            root.editing = false
        }
    }
    
    focus: root.editing
}