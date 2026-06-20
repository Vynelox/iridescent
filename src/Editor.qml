import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"

Window {
    id: mainWindow
    width: 1280
    height: 720
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    title: "Iridescent"
    color: "#0c0d10"

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#0c0d10"

        Rectangle {
            id: topRow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.62
            color: "#0c0d10"

            MediaPool {
                id: mediaPool
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                anchors.leftMargin: 4
                width: 260
            }

            Rectangle {
                id: vSplitter
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: mediaPool.right
                width: 6
                color: "#1a1c24"

                Rectangle {
                    anchors.centerIn: parent
                    width: 2
                    height: 40
                    radius: 1
                    color: "#303340"
                }

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
                            var maxMediaWidth = topRow.width - vSplitter.width - 4 - 10 - 4 - 40
                            newWidth = Math.max(160, Math.min(maxMediaWidth, newWidth))
                            mediaPool.width = newWidth
                        }
                    }
                }
            }

            Viewer {
                id: viewer
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: vSplitter.right
                anchors.right: parent.right
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                anchors.rightMargin: 4
                anchors.leftMargin: 10
            }
        }

        Rectangle {
            id: hSplitter
            anchors.top: topRow.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 6
            color: "#1a1c24"

            Rectangle {
                anchors.centerIn: parent
                width: 40
                height: 2
                radius: 1
                color: "#303340"
            }

            MouseArea {
                id: hSplitterMouse
                anchors.fill: parent
                anchors.topMargin: -6
                anchors.bottomMargin: -6
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