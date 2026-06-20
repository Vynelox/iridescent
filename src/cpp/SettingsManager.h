#pragma once

#include <QObject>
#include <QSettings>
#include <QVariant>
#include <QVariantMap>
#include <QJsonObject>
#include <QJsonArray>
#include "Types.h"

class SettingsManager : public QObject {
    Q_OBJECT

    Q_PROPERTY(int guiScale READ guiScale WRITE setGuiScale NOTIFY guiScaleChanged)
    Q_PROPERTY(bool includeResizeInUndo READ includeResizeInUndo WRITE setIncludeResizeInUndo NOTIFY includeResizeInUndoChanged)
    Q_PROPERTY(QString zoomEpicenter READ zoomEpicenter WRITE setZoomEpicenter NOTIFY zoomEpicenterChanged)
    Q_PROPERTY(int scrollSmooth READ scrollSmooth WRITE setScrollSmooth NOTIFY scrollSmoothChanged)
    Q_PROPERTY(int scrollAmount READ scrollAmount WRITE setScrollAmount NOTIFY scrollAmountChanged)
    Q_PROPERTY(int scrollZoomAmount READ scrollZoomAmount WRITE setScrollZoomAmount NOTIFY scrollZoomAmountChanged)
    Q_PROPERTY(int scrollZoomSmoothness READ scrollZoomSmoothness WRITE setScrollZoomSmoothness NOTIFY scrollZoomSmoothnessChanged)
    Q_PROPERTY(QString viewerControlsType READ viewerControlsType WRITE setViewerControlsType NOTIFY viewerControlsTypeChanged)
    Q_PROPERTY(QString timecodePanel READ timecodePanel WRITE setTimecodePanel NOTIFY timecodePanelChanged)
    Q_PROPERTY(int elevatedPanelDarken READ elevatedPanelDarken WRITE setElevatedPanelDarken NOTIFY elevatedPanelDarkenChanged)
    Q_PROPERTY(int elevatedPanelBlur READ elevatedPanelBlur WRITE setElevatedPanelBlur NOTIFY elevatedPanelBlurChanged)
    Q_PROPERTY(double pnT READ pnT WRITE setPnT NOTIFY pnTChanged)
    Q_PROPERTY(double pnJ READ pnJ WRITE setPnJ NOTIFY pnJChanged)
    Q_PROPERTY(double pnK READ pnK WRITE setPnK NOTIFY pnKChanged)
    Q_PROPERTY(double pnS READ pnS WRITE setPnS NOTIFY pnSChanged)
    Q_PROPERTY(double pnVo READ pnVo WRITE setPnVo NOTIFY pnVoChanged)
    Q_PROPERTY(double pnHb READ pnHb WRITE setPnHb NOTIFY pnHbChanged)
    Q_PROPERTY(double pnHr READ pnHr WRITE setPnHr NOTIFY pnHrChanged)
    Q_PROPERTY(QString torusAnimType READ torusAnimType WRITE setTorusAnimType NOTIFY torusAnimTypeChanged)
    Q_PROPERTY(int torusBounce READ torusBounce WRITE setTorusBounce NOTIFY torusBounceChanged)
    Q_PROPERTY(int torusSpeed READ torusSpeed WRITE setTorusSpeed NOTIFY torusSpeedChanged)
    Q_PROPERTY(int torusSmoothness READ torusSmoothness WRITE setTorusSmoothness NOTIFY torusSmoothnessChanged)

public:
    explicit SettingsManager(QObject *parent = nullptr);
    
    int guiScale() const { return m_guiScale; }
    void setGuiScale(int v);
    
    bool includeResizeInUndo() const { return m_includeResizeInUndo; }
    void setIncludeResizeInUndo(bool v);
    
    QString zoomEpicenter() const { return m_zoomEpicenter; }
    void setZoomEpicenter(const QString &v);
    
    int scrollSmooth() const { return m_scrollSmooth; }
    void setScrollSmooth(int v);
    
    int scrollAmount() const { return m_scrollAmount; }
    void setScrollAmount(int v);
    
    int scrollZoomAmount() const { return m_scrollZoomAmount; }
    void setScrollZoomAmount(int v);
    
    int scrollZoomSmoothness() const { return m_scrollZoomSmoothness; }
    void setScrollZoomSmoothness(int v);
    
    QString viewerControlsType() const { return m_viewerControlsType; }
    void setViewerControlsType(const QString &v);
    
    QString timecodePanel() const { return m_timecodePanel; }
    void setTimecodePanel(const QString &v);
    
    int elevatedPanelDarken() const { return m_elevatedPanelDarken; }
    void setElevatedPanelDarken(int v);
    
    int elevatedPanelBlur() const { return m_elevatedPanelBlur; }
    void setElevatedPanelBlur(int v);
    
    double pnT() const { return m_pnT; }
    void setPnT(double v);
    double pnJ() const { return m_pnJ; }
    void setPnJ(double v);
    double pnK() const { return m_pnK; }
    void setPnK(double v);
    double pnS() const { return m_pnS; }
    void setPnS(double v);
    double pnVo() const { return m_pnVo; }
    void setPnVo(double v);
    double pnHb() const { return m_pnHb; }
    void setPnHb(double v);
    double pnHr() const { return m_pnHr; }
    void setPnHr(double v);
    
    QString torusAnimType() const { return m_torusAnimType; }
    void setTorusAnimType(const QString &v);
    int torusBounce() const { return m_torusBounce; }
    void setTorusBounce(int v);
    int torusSpeed() const { return m_torusSpeed; }
    void setTorusSpeed(int v);
    int torusSmoothness() const { return m_torusSmoothness; }
    void setTorusSmoothness(int v);
    
    Q_INVOKABLE void resetAll();
    Q_INVOKABLE void resetSetting(const QString &key);
    
    Q_INVOKABLE QVariantMap keyboardShortcuts() const;
    Q_INVOKABLE void setKeyboardShortcuts(const QVariantMap &shortcuts);
    Q_INVOKABLE void resetKeyboardShortcut(const QString &action);
    Q_INVOKABLE void resetAllKeyboardShortcuts();
    Q_INVOKABLE bool isKeyboardMatch(const QString &action, int key, bool ctrl, bool shift, bool alt) const;

signals:
    void guiScaleChanged();
    void includeResizeInUndoChanged();
    void zoomEpicenterChanged();
    void scrollSmoothChanged();
    void scrollAmountChanged();
    void scrollZoomAmountChanged();
    void scrollZoomSmoothnessChanged();
    void viewerControlsTypeChanged();
    void timecodePanelChanged();
    void elevatedPanelDarkenChanged();
    void elevatedPanelBlurChanged();
    void pnTChanged();
    void pnJChanged();
    void pnKChanged();
    void pnSChanged();
    void pnVoChanged();
    void pnHbChanged();
    void pnHrChanged();
    void torusAnimTypeChanged();
    void torusBounceChanged();
    void torusSpeedChanged();
    void torusSmoothnessChanged();
    void settingChanged(const QString &key, const QVariant &value);
    void keyboardShortcutsChanged();

private:
    QSettings m_settings;
    
    int m_guiScale = 100;
    bool m_includeResizeInUndo = true;
    QString m_zoomEpicenter = "playneedle";
    int m_scrollSmooth = 50;
    int m_scrollAmount = 100;
    int m_scrollZoomAmount = 25;
    int m_scrollZoomSmoothness = 70;
    QString m_viewerControlsType = "compact";
    QString m_timecodePanel = "both";
    int m_elevatedPanelDarken = 50;
    int m_elevatedPanelBlur = 0;
    double m_pnT = 0.092;
    double m_pnJ = 0.049;
    double m_pnK = 103.0;
    double m_pnS = 16.4;
    double m_pnVo = 0.4;
    double m_pnHb = 0.8;
    double m_pnHr = 1.0;
    QString m_torusAnimType = "pop";
    int m_torusBounce = 60;
    int m_torusSpeed = 250;
    int m_torusSmoothness = 50;
    
    QVariantMap m_keyboardShortcuts;
    
    void loadAll();
    void saveSetting(const QString &key, const QVariant &value);
    void loadKeyboardShortcuts();
    void saveKeyboardShortcuts();
};