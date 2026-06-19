#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>
#include <QDir>
#include <QObject>

#ifdef Q_OS_WIN
#include <windows.h>
#endif

bool showTerminal = true;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    if (!showTerminal) {
        #ifdef Q_OS_WIN
        FreeConsole();
        #endif
    }

    QQmlApplicationEngine engine;

    // TELL THE ENGINE WHERE TO FIND QT'S QML MODULES
    engine.addImportPath("C:/Qt/6.11.1/msvc2022_64/qml");

    // Load QML directly from the source folder
    QString qmlPath = QDir::currentPath() + "/../../../src/animatedbackground.qml";
    const QUrl url = QUrl::fromLocalFile(qmlPath);
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
        
    engine.load(url);

    return app.exec();
}