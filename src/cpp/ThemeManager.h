#pragma once

#include <QObject>
#include <QMap>
#include <QString>
#include <QStringList>
#include <QVariant>
#include <QVariantMap>
#include "Types.h"

class ThemeManager : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString activeThemeName READ activeThemeName WRITE setActiveThemeName NOTIFY themeChanged)
    Q_PROPERTY(QVariantMap activeTheme READ activeTheme NOTIFY themeChanged)

public:
    explicit ThemeManager(QObject *parent = nullptr);
    
    QString activeThemeName() const { return m_activeThemeName; }
    void setActiveThemeName(const QString &name);
    
    QVariantMap activeTheme() const;
    
    Q_INVOKABLE void applyTheme(const QString &themeName);
    Q_INVOKABLE QVariantMap getThemeColors(const QString &themeName) const;
    Q_INVOKABLE void updateColor(const QString &varName, const QString &hex);
    Q_INVOKABLE void resetColor(const QString &varName);
    Q_INVOKABLE QStringList availableThemes() const;
    Q_INVOKABLE QStringList availableFolders() const;
    Q_INVOKABLE QString getParentId(const QString &itemId) const;
    Q_INVOKABLE QVariantMap getFolderHierarchy() const;
    Q_INVOKABLE QString generateStylesheet() const;

signals:
    void themeChanged();

private:
    QString m_activeThemeName = "og-dark";
    QMap<QString, ThemeColors> m_themes;
    QMap<QString, QStringList> m_folders; // folder id -> list of child ids
    QMap<QString, QString> m_parentMap;   // child id -> parent folder id
    QStringList m_topLevelItems;
    
    void initBuiltInThemes();
    void initFolderHierarchy();
    ThemeColors& currentTheme();
    const ThemeColors& currentTheme() const;
};