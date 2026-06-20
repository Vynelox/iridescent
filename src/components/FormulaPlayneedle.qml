import QtQuick
import QtSvg

Item {
    id: root
    property int playneedleHeight: 200
    property real maxWidth: 20
    property string playneedleColor: "#f5f5f5"
    property string glowColor: "rgba(245,245,245,0.4)"
    property var params: ({ t: 0.092, j: 0.049, k: 103, s: 16.4, v_o: 0.4, h_b: 0.8, h_r: 1.0 })
    signal clicked(var event)
    signal mouseDown(var event)

    onParamsChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var p = root.params;
            if (!p) return;
            var steps = 200;
            var halfMaxW = maxWidth / 2;
            
            ctx.beginPath();
            for (var i = 0; i <= steps; i++) {
                var x = i / steps;
                var y = x * height;
                var sigmoid = 1.0 / (1.0 + Math.exp(p.k * (x - p.j)));
                var ribbon = p.h_r * sigmoid * (1.0 - p.t) + p.t;
                var btnCenter = p.v_o * (1.0 - Math.PI / p.s);
                var btnArg = p.s * (x - btnCenter);
                var btnSin = Math.sin(btnArg);
                var btnShape = btnSin * btnSin;
                var dx = x - btnCenter;
                var winArg = -0.1 * dx * (dx - Math.PI / p.s);
                var btnWin = Math.ceil(winArg);
                var button = p.h_b * (1.0 - p.t) * btnShape * btnWin;
                var widthFactor = ribbon + button;
                var halfW = widthFactor * halfMaxW;
                if (i === 0) ctx.moveTo(halfMaxW - halfW, y);
                else ctx.lineTo(halfMaxW - halfW, y);
            }
            for (var i = steps; i >= 0; i--) {
                var x = i / steps;
                var y = x * height;
                var sigmoid = 1.0 / (1.0 + Math.exp(p.k * (x - p.j)));
                var ribbon = p.h_r * sigmoid * (1.0 - p.t) + p.t;
                var btnCenter = p.v_o * (1.0 - Math.PI / p.s);
                var btnArg = p.s * (x - btnCenter);
                var btnSin = Math.sin(btnArg);
                var btnShape = btnSin * btnSin;
                var dx = x - btnCenter;
                var winArg = -0.1 * dx * (dx - Math.PI / p.s);
                var btnWin = Math.ceil(winArg);
                var button = p.h_b * (1.0 - p.t) * btnShape * btnWin;
                var widthFactor = ribbon + button;
                var halfW = widthFactor * halfMaxW;
                ctx.lineTo(halfMaxW + halfW, y);
            }
            ctx.closePath();
            ctx.fillStyle = root.playneedleColor;
            ctx.fill();
        }
    }
    
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked(mouse)
        onPressed: root.mouseDown(mouse)
    }
}
