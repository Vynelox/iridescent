import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"

Window {
    id: mainWindow
    width: 1280
    height: 720
    visible: true
    title: "Iridescent"
    color: "#1e1e1e"

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#1e1e1e"

        Rectangle {
            id: topRow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.6
            color: "#1e1e1e"

            MediaPool {
                id: mediaPool
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 6
                width: 280
            }

            Rectangle {
                id: vSplitter
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: mediaPool.right
                anchors.leftMargin: 6
                width: 5
                color: "#333333"

                MouseArea {
                    id: vSplitterMouse
                    anchors.fill: parent
                    anchors.leftMargin: -6
                    anchors.rightMargin: -6
                    cursorShape: Qt.SizeHorCursor
                    property real dragStartMouseX: 0
                    property real dragStartWidth: 0

                    onPressed: function(mouse) {
                        dragStartMouseX = vSplitterMouse.mapToItem(topRow, mouse.x, mouse.y).x
                        dragStartWidth = mediaPool.width
                    }
                    onPositionChanged: function(mouse) {
                        if (pressedButtons === Qt.LeftButton) {
                            var currentX = vSplitterMouse.mapToItem(topRow, mouse.x, mouse.y).x
                            var delta = currentX - dragStartMouseX
                            var newWidth = dragStartWidth + delta
                            newWidth = Math.max(180, Math.min(450, newWidth))
                            mediaPool.width = newWidth
                        }
                    }
                }

                Rectangle {
                    anchors.centerIn: parent
                    width: 2
                    height: 30
                    radius: 1
                    color: "#555555"
                }
            }

            Viewer {
                id: viewer
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: vSplitter.right
                anchors.right: parent.right
                anchors.margins: 6
            }
        }

        Rectangle {
            id: hSplitter
            anchors.top: topRow.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 5
            color: "#333333"

            MouseArea {
                id: hSplitterMouse
                anchors.fill: parent
                anchors.topMargin: -4
                anchors.bottomMargin: -4
                cursorShape: Qt.SizeVerCursor
                property real dragStartMouseY: 0
                property real dragStartTopHeight: 0

                onPressed: function(mouse) {
                    dragStartMouseY = hSplitterMouse.mapToItem(root, mouse.x, mouse.y).y
                    dragStartTopHeight = topRow.height
                }
                onPositionChanged: function(mouse) {
                    if (pressedButtons === Qt.LeftButton) {
                        var currentY = hSplitterMouse.mapToItem(root, mouse.x, mouse.y).y
                        var delta = currentY - dragStartMouseY
                        var newHeight = dragStartTopHeight + delta
                        newHeight = Math.max(120, Math.min(root.height - 120, newHeight))
                        topRow.height = newHeight
                    }
                }
            }

            Rectangle {
                anchors.centerIn: parent
                width: 30
                height: 2
                radius: 1
                color: "#555555"
            }
        }

        Timeline {
            id: timeline
            anchors.top: hSplitter.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            playheadPosition: 120
        }
    }
}