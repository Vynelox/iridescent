#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>
#include <QDir>
#include <QCoreApplication>
#include <QObject>
#include <QDebug>
#include <QQmlContext>
#include <QFile>
#include <QIcon>

#include "cpp/Types.h"
#include "cpp/Track.h"
#include "cpp/AppState.h"
#include "cpp/SettingsManager.h"
#include "cpp/ThemeManager.h"
#include "cpp/HistoryManager.h"
#include "cpp/MediaModel.h"
#include "cpp/ClipModel.h"
#include "cpp/PlayneedleEngine.h"
#include "cpp/ColorEngine.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/iridescent.ico"));

    // Register C++ types with QML
    qRegisterMetaType<MediaType>("MediaType");
    qRegisterMetaType<TrackType>("TrackType");
    qRegisterMetaType<ShortcutAction>("ShortcutAction");
    qRegisterMetaType<ColorVarName>("ColorVarName");
    qRegisterMetaType<MediaItem>("MediaItem");
    qRegisterMetaType<TimelineClip>("TimelineClip");
    qRegisterMetaType<Fade>("Fade");
    qRegisterMetaType<Track>("Track");
    qRegisterMetaType<PlayneedleParams>("PlayneedleParams");
    qRegisterMetaType<ThemeColors>("ThemeColors");
    
    AppState *appState = new AppState();
    qmlRegisterSingletonType<AppState>("Iridescent", 1, 0, "AppState", [](QQmlEngine*, QJSEngine*) -> QObject* { return new AppState(); });
    qmlRegisterSingletonType<SettingsManager>("Iridescent", 1, 0, "Settings", [](QQmlEngine*, QJSEngine*) -> QObject* { return new SettingsManager(); });
    qmlRegisterSingletonType<ThemeManager>("Iridescent", 1, 0, "Theme", [](QQmlEngine*, QJSEngine*) -> QObject* { return new ThemeManager(); });
    qmlRegisterType<HistoryManager>("Iridescent", 1, 0, "HistoryManager");
    qmlRegisterType<MediaModel>("Iridescent", 1, 0, "MediaModel");
    qmlRegisterType<ClipModel>("Iridescent", 1, 0, "ClipModel");

    QQmlApplicationEngine engine;
    engine.addImportPath("C:/Qt/6.11.1/msvc2022_64/qml");
    engine.rootContext()->setContextProperty("appState", appState);

    QString exePath = QCoreApplication::applicationDirPath();
    QString qmlPath = exePath + "/../../../src/Editor.qml";
    
    qDebug() << "Loading QML from:" << qmlPath;
    qDebug() << "File exists:" << QFile::exists(qmlPath);
    
    const QUrl url = QUrl::fromLocalFile(qmlPath);
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    
    QObject::connect(&engine, &QQmlApplicationEngine::warnings,
        [](const QList<QQmlError>& warnings) {
            for (const QQmlError& error : warnings) {
                qWarning() << "QML Warning:" << error.toString();
            }
        });
        
    engine.load(url);
    
    qDebug() << "Root objects count:" << engine.rootObjects().size();

    return app.exec();
}