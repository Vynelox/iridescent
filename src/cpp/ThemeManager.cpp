#include "ThemeManager.h"
#include <QSettings>

static ThemeColors makeDarkTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#13141a";
    t.colors["--bg-base"] = "#0c0d10";
    t.colors["--bg-viewer"] = "#060608";
    t.colors["--bg-elevated"] = "#1a1c24";
    t.colors["--bg-hover"] = "#21242f";
    t.colors["--border"] = "#262830";
    t.colors["--border-mid"] = "#303340";
    t.colors["--splitter"] = "#08090d";
    t.colors["--text-primary"] = "#e8eaf0";
    t.colors["--text-secondary"] = "#8b8fa8";
    t.colors["--text-muted"] = "#4a4d5e";
    t.colors["--input-field"] = "#2c3349";
    t.colors["--input-field-bg"] = "#16131a";
    t.colors["--playneedle"] = "#f5f5f5";
    t.colors["--video-bg"] = "#0a0a0a";
    t.colors["--accent-blue"] = "#38bdf8";
    return t;
}

static ThemeColors makeLightTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#f0f1f5";
    t.colors["--bg-base"] = "#e8e9ed";
    t.colors["--bg-viewer"] = "#d4d5d9";
    t.colors["--bg-elevated"] = "#ffffff";
    t.colors["--bg-hover"] = "#e2e4e8";
    t.colors["--border"] = "#c5c7cc";
    t.colors["--border-mid"] = "#d8dade";
    t.colors["--splitter"] = "#c8c9cd";
    t.colors["--text-primary"] = "#1a1c24";
    t.colors["--text-secondary"] = "#4a4d5e";
    t.colors["--text-muted"] = "#8b8fa8";
    t.colors["--input-field"] = "#4a5568";
    t.colors["--input-field-bg"] = "#e2e4e8";
    t.colors["--playneedle"] = "#1a1c24";
    t.colors["--video-bg"] = "#d0d2d8";
    t.colors["--accent-blue"] = "#0ea5e9";
    return t;
}

static ThemeColors makeMonokaiTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#272822";
    t.colors["--bg-base"] = "#1c1e19";
    t.colors["--bg-viewer"] = "#1c1e19";
    t.colors["--bg-elevated"] = "#3c3d38";
    t.colors["--bg-hover"] = "#49483e";
    t.colors["--border"] = "#414339";
    t.colors["--border-mid"] = "#5a5c54";
    t.colors["--splitter"] = "#161815";
    t.colors["--text-primary"] = "#f8f8f2";
    t.colors["--text-secondary"] = "#a6e22e";
    t.colors["--text-muted"] = "#75715e";
    t.colors["--input-field"] = "#66d9ef";
    t.colors["--input-field-bg"] = "#3b3a32";
    t.colors["--playneedle"] = "#f92672";
    t.colors["--video-bg"] = "#131411";
    t.colors["--accent-blue"] = "#66d9ef";
    return t;
}

static ThemeColors makeLavenderTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#2D1C4D";
    t.colors["--bg-base"] = "#1B0A3A";
    t.colors["--bg-viewer"] = "#15043A";
    t.colors["--bg-elevated"] = "#392358";
    t.colors["--bg-hover"] = "#432A66";
    t.colors["--border"] = "#684A9C";
    t.colors["--border-mid"] = "#7E5DBA";
    t.colors["--splitter"] = "#15082f";
    t.colors["--text-primary"] = "#E5DEF1";
    t.colors["--text-secondary"] = "#B1A3D0";
    t.colors["--text-muted"] = "#8A7B9C";
    t.colors["--input-field"] = "#7953C2";
    t.colors["--input-field-bg"] = "#27184A";
    t.colors["--playneedle"] = "#C4A8E8";
    t.colors["--video-bg"] = "#0d0618";
    t.colors["--accent-blue"] = "#a78bfa";
    return t;
}

static ThemeColors makeCyberpunkTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#0D0221";
    t.colors["--bg-base"] = "#05010F";
    t.colors["--bg-viewer"] = "#000000";
    t.colors["--bg-elevated"] = "#1A0440";
    t.colors["--bg-hover"] = "#240650";
    t.colors["--border"] = "#FF00C8";
    t.colors["--border-mid"] = "#00F0FF";
    t.colors["--splitter"] = "#1a0035";
    t.colors["--text-primary"] = "#F5F5FF";
    t.colors["--text-secondary"] = "#00F0FF";
    t.colors["--text-muted"] = "#8A2BE2";
    t.colors["--input-field"] = "#FF00C8";
    t.colors["--input-field-bg"] = "#0A0118";
    t.colors["--playneedle"] = "#00F0FF";
    t.colors["--video-bg"] = "#000000";
    t.colors["--accent-blue"] = "#00F0FF";
    return t;
}

static ThemeColors makeOakTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#362E2E";
    t.colors["--bg-base"] = "#2A2222";
    t.colors["--bg-viewer"] = "#1F1717";
    t.colors["--bg-elevated"] = "#4C4242";
    t.colors["--bg-hover"] = "#5D5050";
    t.colors["--border"] = "#706060";
    t.colors["--border-mid"] = "#857373";
    t.colors["--splitter"] = "#231c1c";
    t.colors["--text-primary"] = "#D4C4C4";
    t.colors["--text-secondary"] = "#A99A9A";
    t.colors["--text-muted"] = "#807070";
    t.colors["--input-field"] = "#b0796d";
    t.colors["--input-field-bg"] = "#3F3737";
    t.colors["--playneedle"] = "#d2899d";
    t.colors["--video-bg"] = "#150e0e";
    t.colors["--accent-blue"] = "#f59e0b";
    return t;
}

static ThemeColors makeForestTheme() {
    ThemeColors t;
    t.colors["--bg-panel"] = "#1A332A";
    t.colors["--bg-base"] = "#0F261E";
    t.colors["--bg-viewer"] = "#0A1C15";
    t.colors["--bg-elevated"] = "#2B4D40";
    t.colors["--bg-hover"] = "#3C6656";
    t.colors["--border"] = "#4A7A6C";
    t.colors["--border-mid"] = "#609181";
    t.colors["--splitter"] = "#0b1f1a";
    t.colors["--text-primary"] = "#D8E8D8";
    t.colors["--text-secondary"] = "#A7C2A7";
    t.colors["--text-muted"] = "#7D9E7D";
    t.colors["--input-field"] = "#5F9EA0";
    t.colors["--input-field-bg"] = "#223D34";
    t.colors["--playneedle"] = "#61ff9f";
    t.colors["--video-bg"] = "#050f08";
    t.colors["--accent-blue"] = "#4ade80";
    return t;
}

ThemeManager::ThemeManager(QObject *parent) : QObject(parent) {
    initBuiltInThemes();
    initFolderHierarchy();
    
    // Load saved theme
    QSettings s("JuiceCut", "Iridescent");
    QString saved = s.value("styles.activeTheme", "og-dark").toString();
    if (m_themes.contains(saved)) {
        m_activeThemeName = saved;
    }
}

void ThemeManager::initBuiltInThemes() {
    m_themes["og-dark"] = makeDarkTheme();
    m_themes["og-light"] = makeLightTheme();
    m_themes["monokai"] = makeMonokaiTheme();
    m_themes["lavender"] = makeLavenderTheme();
    m_themes["cyberpunk"] = makeCyberpunkTheme();
    m_themes["oak"] = makeOakTheme();
    m_themes["forest"] = makeForestTheme();
}

void ThemeManager::initFolderHierarchy() {
    m_topLevelItems = QStringList{"vynelox-built-in-folder"};
    m_folders["vynelox-built-in-folder"] = QStringList{"plain-folder"};
    m_folders["plain-folder"] = QStringList{"og-dark", "og-light", "monokai", "lavender", "cyberpunk", "oak", "forest"};
    
    m_parentMap["plain-folder"] = "vynelox-built-in-folder";
    m_parentMap["og-dark"] = "plain-folder";
    m_parentMap["og-light"] = "plain-folder";
    m_parentMap["monokai"] = "plain-folder";
    m_parentMap["lavender"] = "plain-folder";
    m_parentMap["cyberpunk"] = "plain-folder";
    m_parentMap["oak"] = "plain-folder";
    m_parentMap["forest"] = "plain-folder";
}

void ThemeManager::setActiveThemeName(const QString &name) {
    if (m_activeThemeName != name && m_themes.contains(name)) {
        m_activeThemeName = name;
        QSettings s("JuiceCut", "Iridescent");
        s.setValue("styles.activeTheme", name);
        emit themeChanged();
    }
}

QVariantMap ThemeManager::activeTheme() const {
    return currentTheme().toVariantMap();
}

void ThemeManager::applyTheme(const QString &themeName) {
    setActiveThemeName(themeName);
}

QVariantMap ThemeManager::getThemeColors(const QString &themeName) const {
    if (m_themes.contains(themeName)) {
        return m_themes[themeName].toVariantMap();
    }
    return m_themes["og-dark"].toVariantMap();
}

void ThemeManager::updateColor(const QString &varName, const QString &hex) {
    currentTheme().set(varName, hex);
    emit themeChanged();
}

void ThemeManager::resetColor(const QString &varName) {
    // Reset to og-dark default
    if (m_themes["og-dark"].colors.contains(varName)) {
        currentTheme().set(varName, m_themes["og-dark"].colors[varName]);
        emit themeChanged();
    }
}

QStringList ThemeManager::availableThemes() const {
    return m_themes.keys();
}

QStringList ThemeManager::availableFolders() const {
    return m_folders.keys();
}

QString ThemeManager::getParentId(const QString &itemId) const {
    return m_parentMap.value(itemId);
}

QVariantMap ThemeManager::getFolderHierarchy() const {
    QVariantMap hierarchy;
    hierarchy["topLevel"] = QVariantList(m_topLevelItems.begin(), m_topLevelItems.end());
    
    QVariantMap folders;
    for (auto it = m_folders.begin(); it != m_folders.end(); ++it) {
        folders[it.key()] = QVariantList(it.value().begin(), it.value().end());
    }
    hierarchy["folders"] = folders;
    
    QVariantMap parents;
    for (auto it = m_parentMap.begin(); it != m_parentMap.end(); ++it) {
        parents[it.key()] = it.value();
    }
    hierarchy["parents"] = parents;
    
    return hierarchy;
}

QString ThemeManager::generateStylesheet() const {
    const ThemeColors &tc = currentTheme();
    QString ss = ":root {\n";
    for (auto it = tc.colors.begin(); it != tc.colors.end(); ++it) {
        ss += QString("  %1: %2;\n").arg(it.key(), it.value());
    }
    ss += "}\n";
    return ss;
}

ThemeColors& ThemeManager::currentTheme() {
    return m_themes[m_activeThemeName];
}

const ThemeColors& ThemeManager::currentTheme() const {
    return m_themes[m_activeThemeName];
}