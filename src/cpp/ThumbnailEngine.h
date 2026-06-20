#pragma once
#include <QObject>
#include <QVariantList>
#include <QString>

class ThumbnailEngine : public QObject {
    Q_OBJECT
public:
    explicit ThumbnailEngine(QObject *parent = nullptr) : QObject(parent) {}
    Q_INVOKABLE void captureFrames(const QString &src, int count, int width, int height) { Q_UNUSED(src) Q_UNUSED(count) Q_UNUSED(width) Q_UNUSED(height) }
signals:
    void framesReady(const QString &src, const QVariantList &images);
};