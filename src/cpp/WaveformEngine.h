#pragma once
#include <QObject>
#include <QVariantList>
#include <QString>

class WaveformEngine : public QObject {
    Q_OBJECT
public:
    explicit WaveformEngine(QObject *parent = nullptr) : QObject(parent) {}
    Q_INVOKABLE void computePeaks(const QString &src, int samples) { Q_UNUSED(src) Q_UNUSED(samples) }
Q_SIGNALS:
    void peaksReady(const QString &src, const QVariantList &images);
};