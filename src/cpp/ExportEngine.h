#pragma once
#include <QObject>
class ExportEngine : public QObject {
    Q_OBJECT
public:
    explicit ExportEngine(QObject *parent = nullptr) : QObject(parent) {}
    Q_INVOKABLE void startExport(const QString &path, bool video, bool audio) { Q_UNUSED(path) Q_UNUSED(video) Q_UNUSED(audio) }
signals:
    void exportProgress(double percent);
    void exportFinished(bool success, const QString &error);
};