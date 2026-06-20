import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Reusable Slider component
Rectangle {
    id: root
    property string label: ""
    property real value: 0
    property real min: 0
    property real max: 100
    property real step: 1
    property var onChange: null
    property var onReset: null
    property var formatValue: null
    property bool logScale: false
    color: "transparent"
    
    // Map slider 0-1000 to min-max range
    function sliderToValue(sliderVal) {
        var t = sliderVal / 1000.0;
        return root.min + t * (root.max - root.min);
    }
    
    function valueToSlider(val) {
        return ((val - root.min) / (root.max - root.min)) * 1000.0;
    }
    
    onValueChanged: {
        slider.value = valueToSlider(root.value);
    }
    
    ColumnLayout {
        width: parent ? parent.width : 300
        spacing: 6
        
        RowLayout {
            Layout.fillWidth: true
            Text { text: label; color: "#8b8fa8"; font.pixelSize: 13; Layout.fillWidth: true }
            Text { 
                text: root.formatValue ? root.formatValue(root.value) : root.value.toFixed(3)
                color: "#e8eaf0"; font.pixelSize: 12; font.family: "JetBrains Mono, monospace" 
            }
            Button {
                text: "↺"; flat: true; palette.buttonText: "#4a4d5e"
                onClicked: if (root.onReset) root.onReset()
            }
        }
        
        Slider {
            id: slider
            Layout.fillWidth: true
            from: 0; to: 1000; stepSize: 1
            value: valueToSlider(root.value)
            onMoved: {
                var newVal = sliderToValue(value);
                newVal = Math.round(newVal / root.step) * root.step;
                newVal = Math.max(root.min, Math.min(root.max, newVal));
                if (root.onChange) root.onChange(newVal);
            }
        }
        
        RowLayout {
            Layout.fillWidth: true
            Text { text: root.formatValue ? root.formatValue(root.min) : root.min; color: "#4a4d5e"; font.pixelSize: 10 }
            Item { Layout.fillWidth: true }
            Text { text: root.formatValue ? root.formatValue(root.max) : root.max; color: "#4a4d5e"; font.pixelSize: 10 }
        }
    }
}