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

    // ─── C++ Singletons ───
    // AppState { id: appState }
    // Settings { id: settings }
    // Theme { id: theme }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#0c0d10"

        // ─── Header ───
        Rectangle {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 44
            color: "#13141a"
            border.color: "#262830"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 10

                Text {
                    text: "Iridescent"
                    color: "#e8eaf0"
                    font.pixelSize: 15
                    font.bold: true
                }

                Rectangle { Layout.fillWidth: true }

                ToolButton {
                    text: "🎨"
                    flat: true
                    palette.buttonText: "#8b8fa8"
                    onClicked: styleModalLoader.active = true
                }

                ToolButton {
                    text: "⚙"
                    flat: true
                    palette.buttonText: "#8b8fa8"
                    onClicked: settingsLoader.active = true
                }
            }
        }

        // ─── Workspace ───
        Rectangle {
            id: workspace
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "#0c0d10"

            // Top row: MediaPool + Viewer
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

                // Vertical splitter
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
                        anchors.fill: parent
                        anchors.leftMargin: -6
                        anchors.rightMargin: -6
                        cursorShape: Qt.SizeHorCursor
                        property real dragStartMouseX: 0
                        property real dragStartWidth: 0

                        onPressed: function(mouse) {
                            dragStartMouseX = mouse.x + parent.x
                            dragStartWidth = mediaPool.width
                        }
                        onPositionChanged: function(mouse) {
                            if (pressedButtons === Qt.LeftButton) {
                                var globalMouse = mouse.x + parent.x
                                var delta = globalMouse - dragStartMouseX
                                var newWidth = dragStartWidth + delta
                                var maxW = topRow.width - vSplitter.width - 4 - 10 - 4 - 40
                                mediaPool.width = Math.max(160, Math.min(maxW, newWidth))
                                dragStartMouseX = globalMouse
                                dragStartWidth = mediaPool.width
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

            // Horizontal splitter
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
                    anchors.fill: parent
                    anchors.topMargin: -6
                    anchors.bottomMargin: -6
                    cursorShape: Qt.SizeVerCursor
                    property real dragStartMouseY: 0
                    property real dragStartTopHeight: 0

                    onPressed: function(mouse) {
                        dragStartMouseY = mouse.y + parent.y
                        dragStartTopHeight = topRow.height
                    }
                    onPositionChanged: function(mouse) {
                        if (pressedButtons === Qt.LeftButton) {
                            var globalMouse = mouse.y + parent.y
                            var delta = globalMouse - dragStartMouseY
                            var newHeight = dragStartTopHeight + delta
                            topRow.height = Math.max(120, Math.min(root.height - 120, newHeight))
                            dragStartMouseY = globalMouse
                            dragStartTopHeight = topRow.height
                        }
                    }
                }
            }

            // Timeline
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

    // ─── Settings Modal ───
    Loader {
        id: settingsLoader
        active: false
        sourceComponent: Settings {
            onClose: function() { settingsLoader.active = false }
        }
        onLoaded: {
            item.anchors.centerIn = undefined
            item.x = root.width / 2 - item.width / 2
            item.y = root.height / 2 - item.height / 2
        }
    }

    // ─── Styles Modal ───
    Loader {
        id: styleModalLoader
        active: false
        sourceComponent: StylesModal {
            show: true
            setShowStyle: function(v) { styleModalLoader.active = v }
            stylePage: ""
            setStylePage: function(v) { }
        }
    }
}