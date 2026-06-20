#include "SettingsManager.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QKeyEvent>

static const QString STORAGE_KEY = "juicecut.settings.keyboardShortcuts";

static const QMap<QString, QVariantMap> DEFAULT_KEYBOARD_SHORTCUTS = {
    {"undo", {{"keys", QVariantList{QVariantList{"ctrl", "z"}}}}},
    {"redo", {{"keys", QVariantList{QVariantList{"ctrl", "shift", "z"}, QVariantList{"ctrl", "y"}, QVariantList{"ctrl", "alt", "z"}}}}},
    {"timelineZoomToggle", {{"keys", QVariantList{QVariantList{"alt"}}}}},
    {"exitModal", {{"keys", QVariantList{QVariantList{"escape"}}}}}
};

SettingsManager::SettingsManager(QObject *parent)
    : QObject(parent)
    , m_settings("JuiceCut", "Iridescent")
{
    loadAll();
    loadKeyboardShortcuts();
}

void SettingsManager::loadAll() {
    m_guiScale = m_settings.value("guiScale", 100).toInt();
    m_includeResizeInUndo = m_settings.value("includeResizeInUndo", true).toBool();
    m_zoomEpicenter = m_settings.value("zoomEpicenter", "playneedle").toString();
    m_scrollSmooth = m_settings.value("scrollSmooth", 50).toInt();
    m_scrollAmount = m_settings.value("scrollAmount", 100).toInt();
    m_scrollZoomAmount = m_settings.value("scrollZoomAmount", 25).toInt();
    m_scrollZoomSmoothness = m_settings.value("scrollZoomSmoothness", 70).toInt();
    m_viewerControlsType = m_settings.value("viewerControlsType", "compact").toString();
    m_timecodePanel = m_settings.value("timecodePanel", "both").toString();
    m_elevatedPanelDarken = m_settings.value("elevatedPanelDarkenAmount", 50).toInt();
    m_elevatedPanelBlur = m_settings.value("elevatedPanelBlurAmount", 0).toInt();
    m_pnT = m_settings.value("playneedle_t", 0.092).toDouble();
    m_pnJ = m_settings.value("playneedle_j", 0.049).toDouble();
    m_pnK = m_settings.value("playneedle_k", 103.0).toDouble();
    m_pnS = m_settings.value("playneedle_s", 16.4).toDouble();
    m_pnVo = m_settings.value("playneedle_v_o", 0.4).toDouble();
    m_pnHb = m_settings.value("playneedle_h_b", 0.8).toDouble();
    m_pnHr = m_settings.value("playneedle_h_r", 1.0).toDouble();
    m_torusAnimType = m_settings.value("torusAnimType", "pop").toString();
    m_torusBounce = m_settings.value("torusBounce", 60).toInt();
    m_torusSpeed = m_settings.value("torusSpeed", 250).toInt();
    m_torusSmoothness = m_settings.value("torusSmoothness", 50).toInt();
}

void SettingsManager::saveSetting(const QString &key, const QVariant &value) {
    m_settings.setValue(key, value);
    emit settingChanged(key, value);
}

#define SETTER_IMPL(name, type, field, signal) \
void SettingsManager::set##name(type v) { \
    if (field != v) { \
        field = v; \
        saveSetting(#name, v); \
        emit signal(); \
    } \
}

SETTER_IMPL(GuiScale, int, m_guiScale, guiScaleChanged)
SETTER_IMPL(IncludeResizeInUndo, bool, m_includeResizeInUndo, includeResizeInUndoChanged)
SETTER_IMPL(ZoomEpicenter, const QString&, m_zoomEpicenter, zoomEpicenterChanged)
SETTER_IMPL(ScrollSmooth, int, m_scrollSmooth, scrollSmoothChanged)
SETTER_IMPL(ScrollAmount, int, m_scrollAmount, scrollAmountChanged)
SETTER_IMPL(ScrollZoomAmount, int, m_scrollZoomAmount, scrollZoomAmountChanged)
SETTER_IMPL(ScrollZoomSmoothness, int, m_scrollZoomSmoothness, scrollZoomSmoothnessChanged)
SETTER_IMPL(ViewerControlsType, const QString&, m_viewerControlsType, viewerControlsTypeChanged)
SETTER_IMPL(TimecodePanel, const QString&, m_timecodePanel, timecodePanelChanged)
SETTER_IMPL(ElevatedPanelDarken, int, m_elevatedPanelDarken, elevatedPanelDarkenChanged)
SETTER_IMPL(ElevatedPanelBlur, int, m_elevatedPanelBlur, elevatedPanelBlurChanged)
SETTER_IMPL(PnT, double, m_pnT, pnTChanged)
SETTER_IMPL(PnJ, double, m_pnJ, pnJChanged)
SETTER_IMPL(PnK, double, m_pnK, pnKChanged)
SETTER_IMPL(PnS, double, m_pnS, pnSChanged)
SETTER_IMPL(PnVo, double, m_pnVo, pnVoChanged)
SETTER_IMPL(PnHb, double, m_pnHb, pnHbChanged)
SETTER_IMPL(PnHr, double, m_pnHr, pnHrChanged)
SETTER_IMPL(TorusAnimType, const QString&, m_torusAnimType, torusAnimTypeChanged)
SETTER_IMPL(TorusBounce, int, m_torusBounce, torusBounceChanged)
SETTER_IMPL(TorusSpeed, int, m_torusSpeed, torusSpeedChanged)
SETTER_IMPL(TorusSmoothness, int, m_torusSmoothness, torusSmoothnessChanged)

void SettingsManager::resetAll() {
    setGuiScale(100);
    setIncludeResizeInUndo(true);
    setZoomEpicenter("playneedle");
    setScrollSmooth(50);
    setScrollAmount(100);
    setScrollZoomAmount(25);
    setScrollZoomSmoothness(70);
    setViewerControlsType("compact");
    setTimecodePanel("both");
    setElevatedPanelDarken(50);
    setElevatedPanelBlur(0);
    setPnT(0.092);
    setPnJ(0.049);
    setPnK(103.0);
    setPnS(16.4);
    setPnVo(0.4);
    setPnHb(0.8);
    setPnHr(1.0);
    setTorusAnimType("pop");
    setTorusBounce(60);
    setTorusSpeed(250);
    setTorusSmoothness(50);
    resetAllKeyboardShortcuts();
}

void SettingsManager::resetSetting(const QString &key) {
    if (key == "guiScale") setGuiScale(100);
    else if (key == "includeResizeInUndo") setIncludeResizeInUndo(true);
    else if (key == "zoomEpicenter") setZoomEpicenter("playneedle");
    else if (key == "scrollSmooth") setScrollSmooth(50);
    else if (key == "scrollAmount") setScrollAmount(100);
    else if (key == "scrollZoomAmount") setScrollZoomAmount(25);
    else if (key == "scrollZoomSmoothness") setScrollZoomSmoothness(70);
    else if (key == "viewerControlsType") setViewerControlsType("compact");
    else if (key == "timecodePanel") setTimecodePanel("both");
    else if (key == "elevatedPanelDarken") setElevatedPanelDarken(50);
    else if (key == "elevatedPanelBlur") setElevatedPanelBlur(0);
    else if (key == "keyboardShortcuts") resetAllKeyboardShortcuts();
}

void SettingsManager::loadKeyboardShortcuts() {
    QByteArray raw = m_settings.value(STORAGE_KEY).toByteArray();
    if (raw.isEmpty()) {
        // Load defaults
        for (auto it = DEFAULT_KEYBOARD_SHORTCUTS.begin(); it != DEFAULT_KEYBOARD_SHORTCUTS.end(); ++it) {
            m_keyboardShortcuts[it.key()] = it.value()["keys"];
        }
        return;
    }
    QJsonDocument doc = QJsonDocument::fromJson(raw);
    if (doc.isObject()) {
        QJsonObject obj = doc.object();
        for (auto it = obj.begin(); it != obj.end(); ++it) {
            QVariantList combos;
            QJsonArray arr = it.value().toArray();
            for (const QJsonValue &combo : arr) {
                QVariantList keys;
                for (const QJsonValue &k : combo.toArray()) {
                    keys.append(k.toString());
                }
                combos.append(QVariant(keys));
            }
            m_keyboardShortcuts[it.key()] = combos;
        }
    }
}

void SettingsManager::saveKeyboardShortcuts() {
    QJsonObject obj;
    for (auto it = m_keyboardShortcuts.begin(); it != m_keyboardShortcuts.end(); ++it) {
        QJsonArray combos;
        QVariantList comboList = it.value().toList();
        for (const QVariant &combo : comboList) {
            QJsonArray keys;
            for (const QVariant &k : combo.toList()) {
                keys.append(k.toString());
            }
            combos.append(keys);
        }
        obj[it.key()] = combos;
    }
    QJsonDocument doc(obj);
    m_settings.setValue(STORAGE_KEY, doc.toJson(QJsonDocument::Compact));
}

QVariantMap SettingsManager::keyboardShortcuts() const {
    return m_keyboardShortcuts;
}

void SettingsManager::setKeyboardShortcuts(const QVariantMap &shortcuts) {
    m_keyboardShortcuts = shortcuts;
    saveKeyboardShortcuts();
    emit keyboardShortcutsChanged();
    emit settingChanged("keyboardShortcuts", shortcuts);
}

void SettingsManager::resetKeyboardShortcut(const QString &action) {
    if (DEFAULT_KEYBOARD_SHORTCUTS.contains(action)) {
        m_keyboardShortcuts[action] = DEFAULT_KEYBOARD_SHORTCUTS[action]["keys"];
        saveKeyboardShortcuts();
        emit keyboardShortcutsChanged();
    }
}

void SettingsManager::resetAllKeyboardShortcuts() {
    for (auto it = DEFAULT_KEYBOARD_SHORTCUTS.begin(); it != DEFAULT_KEYBOARD_SHORTCUTS.end(); ++it) {
        m_keyboardShortcuts[it.key()] = it.value()["keys"];
    }
    saveKeyboardShortcuts();
    emit keyboardShortcutsChanged();
    emit settingChanged("keyboardShortcuts", m_keyboardShortcuts);
}

bool SettingsManager::isKeyboardMatch(const QString &action, int key, bool ctrl, bool shift, bool alt) const {
    if (!m_keyboardShortcuts.contains(action)) return false;
    
    QStringList eventKeys;
    if (ctrl) eventKeys.append("ctrl");
    if (shift) eventKeys.append("shift");
    if (alt) eventKeys.append("alt");
    
    // Map Qt key to string
    QString keyStr;
    if (key == Qt::Key_Space) keyStr = "space";
    else if (key == Qt::Key_Escape) keyStr = "escape";
    else if (key == Qt::Key_Return || key == Qt::Key_Enter) keyStr = "enter";
    else if (key >= Qt::Key_A && key <= Qt::Key_Z) keyStr = QChar(key).toLower();
    else if (key >= Qt::Key_0 && key <= Qt::Key_9) keyStr = QString::number(key - Qt::Key_0);
    else if (key >= Qt::Key_F1 && key <= Qt::Key_F12) keyStr = "f" + QString::number(key - Qt::Key_F1 + 1);
    else keyStr = QKeySequence(key).toString().toLower();
    
    if (!keyStr.isEmpty()) eventKeys.append(keyStr);
    
    if (eventKeys.isEmpty()) return false;
    
    QVariantList combos = m_keyboardShortcuts[action].toList();
    for (const QVariant &comboVar : combos) {
        QStringList combo = comboVar.toStringList();
        if (combo.size() != eventKeys.size()) continue;
        QSet<QString> comboSet;
        for (const QString &k : combo) comboSet.insert(k.toLower());
        QSet<QString> eventSet;
        for (const QString &k : eventKeys) eventSet.insert(k.toLower());
        if (comboSet == eventSet) return true;
    }
    return false;
}