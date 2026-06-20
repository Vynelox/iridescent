import QtQuick

Canvas {
    id: root
    property string src: ""
    property string color: "#d1fae5"
    property var peaks: []
    
    onPaint: {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);
        if (!peaks || peaks.length === 0) return;
        
        ctx.strokeStyle = root.color;
        ctx.lineWidth = 1;
        var mid = height / 2;
        ctx.beginPath();
        for (var i = 0; i < peaks.length; i++) {
            var v = peaks[i];
            var y = v * (height / 2 - 1);
            ctx.moveTo(i + 0.5, mid - y);
            ctx.lineTo(i + 0.5, mid + y);
        }
        ctx.stroke();
    }
}