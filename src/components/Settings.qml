import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property var onClose: null
    color: "transparent"
    
    signal settingChanged(string key, var value)
    
    function resetAll() { 
        appState.resetPlayneedleParam("t");
        appState.resetPlayneedleParam("j");
        appState.resetPlayneedleParam("k");
        appState.resetPlayneedleParam("s");
        appState.resetPlayneedleParam("v_o");
        appState.resetPlayneedleParam("h_b");
        appState.resetPlayneedleParam("h_r");
    }
    function resetSetting(key) { 
        appState.resetPlayneedleParam(key);
    }
    
    Rectangle {
        width: 480; height: 500
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
                
                Text {
                    anchors.centerIn: parent
                    text: "Settings"
                    color: "#e8eaf0"
                    font.pixelSize: 14
                    font.bold: true
                }
                
                Button {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "×"
                    flat: true
                    palette.buttonText: "#8b8fa8"
                    onClicked: if (root.onClose) root.onClose()
                }
            }
            
            // Tabs
            RowLayout {
                Layout.fillWidth: true
                Layout.margins: 8
                spacing: 4
                
                Repeater {
                    model: ["Playneedle", "Keyboard", "Sliders", "Checkboxes", "Multiselects", "Components"]
                    Button {
                        text: modelData
                        flat: true
                        palette.buttonText: tabIndex === 0 ? "#38bdf8" : "#8b8fa8"
                        font.pixelSize: 12
                        property int tabIndex: index
                    }
                }
            }
            
            // Content
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 8
                contentWidth: availableWidth
                
                ColumnLayout {
                    width: parent.width
                    spacing: 4
                    
                    // Playneedle params
                    Adjustables {
                        label: "t (thickness)"
                        value: appState.playneedleParams.t
                        min: 0; max: 0.5; step: 0.001
                        formatValue: function(v) { return v.toFixed(3); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.t = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("t"); }
                    }
                    
                    Adjustables {
                        label: "j (sigmoid center)"
                        value: appState.playneedleParams.j
                        min: 0; max: 0.5; step: 0.001
                        formatValue: function(v) { return v.toFixed(3); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.j = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("j"); }
                    }
                    
                    Adjustables {
                        label: "k (sigmoid steepness)"
                        value: appState.playneedleParams.k
                        min: 1; max: 500; step: 1
                        formatValue: function(v) { return v.toFixed(0); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.k = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("k"); }
                    }
                    
                    Adjustables {
                        label: "s (button frequency)"
                        value: appState.playneedleParams.s
                        min: 1; max: 50; step: 0.1
                        formatValue: function(v) { return v.toFixed(1); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.s = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("s"); }
                    }
                    
                    Adjustables {
                        label: "v_o (button position)"
                        value: appState.playneedleParams.v_o
                        min: 0; max: 1; step: 0.01
                        formatValue: function(v) { return v.toFixed(2); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.v_o = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("v_o"); }
                    }
                    
                    Adjustables {
                        label: "h_b (button height)"
                        value: appState.playneedleParams.h_b
                        min: 0; max: 2; step: 0.01
                        formatValue: function(v) { return v.toFixed(2); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.h_b = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("h_b"); }
                    }
                    
                    Adjustables {
                        label: "h_r (ribbon height)"
                        value: appState.playneedleParams.h_r
                        min: 0; max: 2; step: 0.01
                        formatValue: function(v) { return v.toFixed(2); }
                        onChange: function(v) {
                            var p = appState.playneedleParams;
                            p.h_r = v;
                            appState.playneedleParams = p;
                        }
                        onReset: function() { root.resetSetting("h_r"); }
                    }
                    
                    Item { Layout.fillHeight: true }
                }
            }
        }
    }
}