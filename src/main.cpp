#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>
#include <QDir>
#include <QCoreApplication>
#include <QObject>
#include <QDebug>

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
    engine.addImportPath("C:/Qt/6.11.1/msvc2022_64/qml");

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