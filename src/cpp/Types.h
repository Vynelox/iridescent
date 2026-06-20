#pragma once

#include <QString>
#include <QVector>
#include <QMap>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>
#include <QMetaType>

enum class MediaType {
    Video,
    Audio,
    Image
};

enum class TrackType {
    Video,
    Audio
};

enum class ShortcutAction {
    Undo,
    Redo,
    TimelineZoomToggle,
    ExitModal
};

enum class ColorVarName {
    BgPanel,
    BgBase,
    BgViewer,
    BgElevated,
    BgHover,
    Border,
    BorderMid,
    Splitter,
    TextPrimary,
    TextSecondary,
    TextMuted,
    InputField,
    InputFieldBg,
    Playneedle,
    VideoBg,
    AccentBlue
};

struct ThemeColors {
    QMap<QString, QString> colors;
    
    QString get(const QString &key) const { return colors.value(key); }
    void set(const QString &key, const QString &value) { colors[key] = value; }
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        for (auto it = colors.begin(); it != colors.end(); ++it)
            m[it.key()] = it.value();
        return m;
    }
    
    static ThemeColors fromVariantMap(const QVariantMap &m) {
        ThemeColors tc;
        for (auto it = m.begin(); it != m.end(); ++it)
            tc.colors[it.key()] = it.value().toString();
        return tc;
    }
};

struct PlayneedleParams {
    double t = 0.092;
    double j = 0.049;
    double k = 103.0;
    double s = 16.4;
    double v_o = 0.4;
    double h_b = 0.8;
    double h_r = 1.0;
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        m["t"] = t; m["j"] = j; m["k"] = k; m["s"] = s;
        m["v_o"] = v_o; m["h_b"] = h_b; m["h_r"] = h_r;
        return m;
    }
    
    static PlayneedleParams fromVariantMap(const QVariantMap &m) {
        PlayneedleParams p;
        if (m.contains("t")) p.t = m["t"].toDouble();
        if (m.contains("j")) p.j = m["j"].toDouble();
        if (m.contains("k")) p.k = m["k"].toDouble();
        if (m.contains("s")) p.s = m["s"].toDouble();
        if (m.contains("v_o")) p.v_o = m["v_o"].toDouble();
        if (m.contains("h_b")) p.h_b = m["h_b"].toDouble();
        if (m.contains("h_r")) p.h_r = m["h_r"].toDouble();
        return p;
    }
};

struct AppSnapshot {
    QVariantList clips;
    QVariantMap mediaItems;
    QStringList selectedIds;
    int playhead = 0;
    QVariantMap settings;
    QVariantMap layout;
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        m["clips"] = clips;
        m["mediaItems"] = mediaItems;
        m["selectedIds"] = selectedIds;
        m["playhead"] = playhead;
        m["settings"] = settings;
        m["layout"] = layout;
        return m;
    }
    
    static AppSnapshot fromVariantMap(const QVariantMap &m) {
        AppSnapshot s;
        if (m.contains("clips")) s.clips = m["clips"].toList();
        if (m.contains("mediaItems")) s.mediaItems = m["mediaItems"].toMap();
        if (m.contains("selectedIds")) s.selectedIds = m["selectedIds"].toStringList();
        if (m.contains("playhead")) s.playhead = m["playhead"].toInt();
        if (m.contains("settings")) s.settings = m["settings"].toMap();
        if (m.contains("layout")) s.layout = m["layout"].toMap();
        return s;
    }
};

inline QString colorVarNameToString(ColorVarName name) {
    switch (name) {
    case ColorVarName::BgPanel: return "--bg-panel";
    case ColorVarName::BgBase: return "--bg-base";
    case ColorVarName::BgViewer: return "--bg-viewer";
    case ColorVarName::BgElevated: return "--bg-elevated";
    case ColorVarName::BgHover: return "--bg-hover";
    case ColorVarName::Border: return "--border";
    case ColorVarName::BorderMid: return "--border-mid";
    case ColorVarName::Splitter: return "--splitter";
    case ColorVarName::TextPrimary: return "--text-primary";
    case ColorVarName::TextSecondary: return "--text-secondary";
    case ColorVarName::TextMuted: return "--text-muted";
    case ColorVarName::InputField: return "--input-field";
    case ColorVarName::InputFieldBg: return "--input-field-bg";
    case ColorVarName::Playneedle: return "--playneedle";
    case ColorVarName::VideoBg: return "--video-bg";
    case ColorVarName::AccentBlue: return "--accent-blue";
    }
    return "";
}

inline QString shortcutActionToString(ShortcutAction action) {
    switch (action) {
    case ShortcutAction::Undo: return "undo";
    case ShortcutAction::Redo: return "redo";
    case ShortcutAction::TimelineZoomToggle: return "timelineZoomToggle";
    case ShortcutAction::ExitModal: return "exitModal";
    }
    return "";
}

inline int qHash(const PlayneedleParams &p, int seed = 0) {
    return qHash(QVector<double>{p.t, p.j, p.k, p.s, p.v_o, p.h_b, p.h_r}, seed);
}

inline bool operator==(const PlayneedleParams &a, const PlayneedleParams &b) {
    return a.t == b.t && a.j == b.j && a.k == b.k && a.s == b.s &&
           a.v_o == b.v_o && a.h_b == b.h_b && a.h_r == b.h_r;
}