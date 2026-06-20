pragma Singleton
import QtQuick

QtObject {
    // ─── Colors (mirrors CSS custom properties) ───
    property string bgPanel: "#13141a"
    property string bgBase: "#0c0d10"
    property string bgViewer: "#060608"
    property string bgElevated: "#1a1c24"
    property string bgHover: "#21242f"
    property string border: "#262830"
    property string borderMid: "#303340"
    property string splitter: "#08090d"
    property string textPrimary: "#e8eaf0"
    property string textSecondary: "#8b8fa8"
    property string textMuted: "#4a4d5e"
    property string inputField: "#2c3349"
    property string inputFieldBg: "#16131a"
    property string playneedle: "#f5f5f5"
    property string videoBg: "#0a0a0a"
    property string accentBlue: "#38bdf8"
    property string accentGreen: "#34d399"
    property string accentAmber: "#fbbf24"
    property string accentRose: "#f472b6"
    property string accentOrange: "#fb923c"
    
    // Clip colors
    property string clipVideoBg: "#0e2d4a"
    property string clipVideoBorder: "#0ea5e9"
    property string clipAudioBg: "#0a3226"
    property string clipAudioBorder: "#10b981"
    property string clipImageBg: "#2d1f06"
    property string clipImageBorder: "#f59e0b"
    
    // ─── Spacing ───
    property real spaceXs: 4
    property real spaceSm: 8
    property real spaceMd: 12
    property real spaceLg: 16
    property real spaceXl: 24
    
    // ─── Radii ───
    property real radiusSm: 4
    property real radiusMd: 6
    property real radiusLg: 10
    
    // ─── Bar heights ───
    property real barHeightSm: 28
    property real barHeightMd: 36
    property real barHeightLg: 44
    
    // ─── Bar widths ───
    property real barWidthSm: 60
    property real barWidthMd: 112
    
    // ─── Icon sizes ───
    property real iconSm: 12
    property real iconMd: 16
    property real iconLg: 24
    
    // ─── Font ───
    property string fontFamily: "Inter, Segoe UI"
    property string monoFontFamily: "JetBrains Mono, Consolas, monospace"
    property real fontSize: 13
    property real fontSizeSmall: 11
    property real fontSizeMono: 12
    
    // ─── GUI Scale ───
    property real guiScale: 1.0
    
    // ─── Computed scaled values ───
    property real scaledFontSize: fontSize * guiScale
    property real scaledSpaceXs: spaceXs * guiScale
    property real scaledSpaceSm: spaceSm * guiScale
    property real scaledSpaceMd: spaceMd * guiScale
    property real scaledSpaceLg: spaceLg * guiScale
    property real scaledSpaceXl: spaceXl * guiScale
    property real scaledBarHeightMd: barHeightMd * guiScale
    property real scaledBarHeightLg: barHeightLg * guiScale
    property real scaledBarWidthSm: barWidthSm * guiScale
    property real scaledIconSm: iconSm * guiScale
    property real scaledIconMd: iconMd * guiScale
    property real scaledIconLg: iconLg * guiScale
    
    // ─── Track height ───
    property real trackHeight: 64 * guiScale
    
    // ─── Ruler height ───
    property real rulerHeight: 32 * guiScale
    
    // ─── Playhead ───
    property real playheadMaxWidth: 20 * guiScale
    property string playheadGlow: "rgba(248, 113, 113, 0.4)"
    
    // ─── Modal overlay ───
    property string modalOverlayBg: "rgba(0,0,0,0.7)"
    property real modalOverlayBlur: 0
    
    // ─── Update from C++ ThemeManager ───
    function updateFromTheme(themeColors) {
        if (themeColors["--bg-panel"]) bgPanel = themeColors["--bg-panel"];
        if (themeColors["--bg-base"]) bgBase = themeColors["--bg-base"];
        if (themeColors["--bg-viewer"]) bgViewer = themeColors["--bg-viewer"];
        if (themeColors["--bg-elevated"]) bgElevated = themeColors["--bg-elevated"];
        if (themeColors["--bg-hover"]) bgHover = themeColors["--bg-hover"];
        if (themeColors["--border"]) border = themeColors["--border"];
        if (themeColors["--border-mid"]) borderMid = themeColors["--border-mid"];
        if (themeColors["--splitter"]) splitter = themeColors["--splitter"];
        if (themeColors["--text-primary"]) textPrimary = themeColors["--text-primary"];
        if (themeColors["--text-secondary"]) textSecondary = themeColors["--text-secondary"];
        if (themeColors["--text-muted"]) textMuted = themeColors["--text-muted"];
        if (themeColors["--input-field"]) inputField = themeColors["--input-field"];
        if (themeColors["--input-field-bg"]) inputFieldBg = themeColors["--input-field-bg"];
        if (themeColors["--playneedle"]) playneedle = themeColors["--playneedle"];
        if (themeColors["--video-bg"]) videoBg = themeColors["--video-bg"];
        if (themeColors["--accent-blue"]) accentBlue = themeColors["--accent-blue"];
    }
}