import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property bool show: false
    property var setShowStyle: null
    property string stylePage: ""
    property var setStylePage: null
    color: "transparent"
    
    visible: show
    
    Rectangle {
        width: 480; height: Math.round(0.72 * 600)
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
                
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    
                    Button {
                        text: "←"; flat: true; palette.buttonText: "#8b8fa8"
                        visible: root.stylePage !== ""
                        onClicked: {
                            if (root.setStylePage) root.setStylePage("")
                        }
                    }
                    
                    Text {
                        text: root.stylePage ? root.stylePage : "Styles"
                        color: "#e8eaf0"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Button {
                        text: "×"; flat: true; palette.buttonText: "#8b8fa8"
                        Layout.alignment: Qt.AlignRight
                        onClicked: if (root.setShowStyle) root.setShowStyle(false)
                    }
                }
            }
            
            // Content
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                GridLayout {
                    width: parent ? parent.width : 400
                    columns: 3
                    columnSpacing: 12
                    rowSpacing: 8
                    anchors.margins: 16
                    
                    Repeater {
                        model: ["Vynelox built-in"]
                        Button {
                            Layout.preferredWidth: 90
                            Layout.preferredHeight: 100
                            Column {
                                anchors.centerIn: parent
                                spacing: 6
                                Text { text: "📁"; font.pixelSize: 36; anchors.horizontalCenter: parent.horizontalCenter }
                                Text { text: modelData; color: "#8b8fa8"; font.pixelSize: 11; anchors.horizontalCenter: parent.horizontalCenter }
                            }
                            flat: true
                            onClicked: {
                                if (root.setStylePage) root.setStylePage("vynelox-built-in-folder")
                            }
                        }
                    }
                }
            }
        }
    }
}