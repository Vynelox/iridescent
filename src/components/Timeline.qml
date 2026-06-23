import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property int playheadPosition: 120
    property real contentX: 0
    property real targetContentX: 0

    onContentXChanged: {// when the x coordinate of the timeline camera changes
        gridCanvas.requestPaint()
    }

    NumberAnimation on contentX {
        id: scrollAnimation
        duration: 200 //PUT THIS IN THE SETTINGS!!!! (scroll smoothness)
        easing.type: Easing.OutCubic
    }

    signal playheadMoved(int position)
    signal zoomIn()
    signal zoomOut()

    color: "#0c0d10"

    ColumnLayout { //flex direction column (timeline header, timeline tracks)
        anchors.fill: parent
        anchors.margins: 0

        Rectangle {//timeline background (the visual rectangle for the columnlayout)
            Layout.fillWidth: true
            height: 36
            color: "#13141a"
            radius: 0

            RowLayout {//timeline header
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 10
                //[GUI SCALE] add a height

                Text {
                    text: "Timeline"
                    color: "#8b8fa8"
                    font.pixelSize: 11
                    font.family: "Inter, Segoe UI"
                    font.bold: true
                    font.letterSpacing: 0.8
                }

                Rectangle { Layout.fillWidth: true }

                RoundButton { //minus button (zoom out)
                    text: "-"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#4a4d5e"
                    font.pixelSize: 14 //GUI SCALE
                    onClicked: root.zoomOut()
                }
                RoundButton { //plus button (zoom in)
                    text: "+"
                    flat: true
                    palette.button: "transparent"
                    palette.buttonText: "#4a4d5e"
                    font.pixelSize: 14 //GUI SCALE
                    onClicked: root.zoomIn()
                }

                Rectangle { Layout.fillWidth: true }

                Text { //timecode
                    text: {
                        var totalSec = root.playheadPosition / 40
                        var h = Math.floor(totalSec / 3600)
                        var m = Math.floor((totalSec % 3600) / 60)
                        var s = Math.floor(totalSec % 60)
                        var f = Math.floor((totalSec - Math.floor(totalSec)) * 30)
                        return String(h).padStart(2, '0') + ":" +
                               String(m).padStart(2, '0') + ":" +
                               String(s).padStart(2, '0') + ":" +
                               String(f).padStart(2, '0')
                    }
                    color: "#8b8fa8"
                    font.pixelSize: 11 //GUI SCALE
                    font.family: "JetBrains Mono, Consolas, monospace"
                }
            }
        }//end of timeline header


        RowLayout {//timeline tracks
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            anchors.fill: parent //choose between this and the above two lines
            //hides/shows the timeline header bar
            spacing: 0 //default spacing between every child element

            Rectangle {//media tracks sidebar
                width: 60 //GUI SCALE
                Layout.fillHeight: true
                color: "#13141a"
                radius: 0

                Rectangle {//the grey filler rectangle at the top of the sidebar (the ruler)
                    id: sidebarRuler
                    width: parent.width
                    height: 24
                    color: "#1a1c24"
                    anchors.top: parent.top
                }

                Item {//contains all the labels of the media tracks sidebar (v1, a1, etc)
                    id: labelsContainer
                    width: parent.width
                    height: 56 + 56 //note: this will change depending on the number of tracks, which will be added later
                    anchors.centerIn: parent //does the same thing as
                    //anchors.verticalCenter: parent.verticalCenter
                    //anchors.horizontalCenter: parent.horizontalCenter


                    Rectangle {
                        width: parent.width
                        height: 56
                        color: "#13141a"
                        anchors.top: parent.top

                        RowLayout {//the v1 next to the video track icon
                            anchors.centerIn: parent
                            spacing: 5

                            Text {//v1 text
                                text: "V1"
                                color: "#38bdf8"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "Inter, Segoe UI"
                            }
                            Rectangle {//v1 icon
                                width: 20
                                height: 18
                                color: "transparent"
                                Canvas {
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.strokeStyle = "#8b8fa8"
                                        ctx.lineWidth = 1.5
                                        ctx.strokeRect(2, 3, 14, 12)
                                        ctx.fillStyle = "#8b8fa8"
                                        ctx.fillRect(5, 1, 3, 3)
                                        ctx.fillRect(12, 1, 3, 3)
                                        ctx.fillRect(5, 14, 3, 3)
                                        ctx.fillRect(12, 14, 3, 3)
                                        ctx.beginPath()
                                        ctx.moveTo(2, 7)
                                        ctx.lineTo(16, 7)
                                        ctx.stroke()
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 56
                        color: "#13141a"
                        anchors.top: parent.top
                        anchors.topMargin: 56

                        RowLayout {//the a1 next to the audio track icon
                            anchors.centerIn: parent
                            spacing: 5

                            Text {//a1 text
                                text: "A1"
                                color: "#34d399"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "Inter, Segoe UI"
                            }
                            Rectangle {//a1 icon
                                width: 20
                                height: 18
                                color: "transparent"
                                Canvas {
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.fillStyle = "#8b8fa8"
                                        ctx.strokeStyle = "#8b8fa8"
                                        ctx.lineWidth = 1.5
                                        ctx.beginPath()
                                        ctx.ellipse(4, 13, 4, 3, -0.3, 0, Math.PI * 2)
                                        ctx.fill()
                                        ctx.fillRect(7, 3, 1.5, 10)
                                        ctx.beginPath()
                                        ctx.ellipse(11, 10, 4, 3, -0.3, 0, Math.PI * 2)
                                        ctx.fill()
                                        ctx.fillRect(14, 2, 1.5, 8)
                                        ctx.beginPath()
                                        ctx.moveTo(8.5, 3)
                                        ctx.lineTo(15.5, 2)
                                        ctx.lineTo(15.5, 5)
                                        ctx.lineTo(8.5, 6)
                                        ctx.closePath()
                                        ctx.fill()
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {//media tracks. next element in rowlayout after the sidebar.
                id: tracksArea
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                color: "#0c0d10"

                Rectangle {
                    id: ruler
                    width: parent.width
                    height: 24
                    color: "#1a1c24"
                    anchors.top: parent.top
                    clip: true

                    Repeater {//potentially use this for media tracks?
                        model: 50
                        delegate: Rectangle {
                            x: index * 80 + root.contentX + 4
                            y: 0
                            width: 80
                            height: 24
                            color: "transparent"

                            Text {
                                anchors.left: parent.left
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 4
                                text: {
                                    var totalSec = index * 2
                                    var m = Math.floor(totalSec / 60)
                                    var s = totalSec % 60
                                    return String(m).padStart(2, '0') + ":" + String(s).padStart(2, '0')
                                }
                                color: "#4a4d5e"
                                font.pixelSize: 9
                                font.family: "JetBrains Mono, Consolas, monospace"
                            }

                            Rectangle {
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                width: 1
                                height: 6
                                color: "#262830"
                            }
                        }
                    }
                }

                Item {
                    id: tracksContainer
                    width: parent.width
                    height: 56 + 56
                    anchors.centerIn: parent
                    x: root.contentX
                }

                Canvas {
                    id: gridCanvas
                    anchors.fill: parent
                    anchors.topMargin: ruler.height
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#1a1c24"
                        ctx.lineWidth = 1

                        var trackY = tracksContainer.y - ruler.height
                        var trackH = tracksContainer.height

                        var lineY1 = trackY
                        var lineY2 = trackY + 56
                        var lineY3 = trackY + trackH

                        ctx.beginPath()
                        ctx.moveTo(0, lineY1)
                        ctx.lineTo(width, lineY1)
                        ctx.stroke()

                        ctx.beginPath()
                        ctx.moveTo(0, lineY2)
                        ctx.lineTo(width, lineY2)
                        ctx.stroke()

                        ctx.beginPath()
                        ctx.moveTo(0, lineY3)
                        ctx.lineTo(width, lineY3)
                        ctx.stroke()

                        var tickSpacing = 80
                        var gridOffset = 4
                        var startX = root.contentX + gridOffset
                        for (var tx = startX; tx < width; tx += tickSpacing) {
                            ctx.beginPath()
                            ctx.moveTo(tx, 0)
                            ctx.lineTo(tx, height)
                            ctx.stroke()
                        }
                    }
                }

                MouseArea { //for dragging the playneedle
                    anchors.fill: parent
                    anchors.topMargin: ruler.height
                    property bool isDragging: false

                    onPressed: function(mouse) {
                        isDragging = true
                        var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x - root.contentX
                        root.playheadPosition = Math.max(0, globalX)
                        root.playheadMoved(root.playheadPosition)
                    }
                    onPositionChanged: function(mouse) {
                        if (isDragging && pressedButtons === Qt.LeftButton) {
                            var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x - root.contentX
                            root.playheadPosition = Math.max(0, globalX)
                            root.playheadMoved(root.playheadPosition)
                        }
                    }
                    onReleased: function() {
                        isDragging = false
                    }
                }

                Rectangle {//playneedle
                    id: playheadLine
                    width: 2
                    height: tracksArea.height
                    color: "#f87171"
                    x: root.playheadPosition + root.contentX
                }

                Rectangle {
                    id: playheadHandle
                    width: 14
                    height: tracksArea.height
                    x: root.playheadPosition + root.contentX - 6
                    y: 0
                    color: "transparent"

                    Rectangle {
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 10
                        height: 10
                        color: "#f87171"
                        rotation: 45
                        transformOrigin: Item.Center
                    }

                    MouseArea {
                        id: playheadMouseArea
                        anchors.fill: parent
                        anchors.leftMargin: -6
                        anchors.rightMargin: -6
                        property bool isDragging: false

                        onPressed: function(mouse) {
                            isDragging = true
                            var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x - root.contentX
                            root.playheadPosition = Math.max(0, globalX)
                            root.playheadMoved(root.playheadPosition)
                        }
                        onPositionChanged: function(mouse) {
                            if (isDragging && pressedButtons === Qt.LeftButton) {
                                var globalX = mapToItem(tracksArea, mouse.x, mouse.y).x - root.contentX
                                root.playheadPosition = Math.max(0, globalX)
                                root.playheadMoved(root.playheadPosition)
                            }
                        }
                        onReleased: function() {
                            isDragging = false
                        }
                    }
                }

                WheelHandler {
                    target: null
                    onWheel: function(event) {
                        var delta = event.angleDelta.x !== 0 ? event.angleDelta.x : event.angleDelta.y
                        var maxScroll = Math.min(0, tracksArea.width - 50 * 80)
                        root.targetContentX = Math.max(maxScroll, Math.min(0, root.targetContentX + delta * 0.5))
                        scrollAnimation.to = root.targetContentX
                        scrollAnimation.from = root.contentX
                        scrollAnimation.restart()
                        event.accepted = true
                    }
                }
            }
        }
    }
    
}