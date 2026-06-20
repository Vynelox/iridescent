#pragma once

#include <QObject>
#include <QAbstractNativeEventFilter>

#ifdef Q_OS_WIN
#include <windows.h>
#endif

class Win32EventFilter : public QObject, public QAbstractNativeEventFilter {
    Q_OBJECT
public:
#ifdef Q_OS_WIN
    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) override;
#else
    bool nativeEventFilter(const QByteArray &, void *, qintptr *) override { return false; }
#endif
signals:
    void stylesRequested();
    void settingsRequested();
};