#include "Win32EventFilter.h"

#ifdef Q_OS_WIN

bool Win32EventFilter::nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) {
    Q_UNUSED(result);
    if (eventType == "windows_generic_MSG") {
        MSG *msg = static_cast<MSG*>(message);
        if (msg->message == WM_COMMAND) {
            WORD id = LOWORD(msg->wParam);
            switch (id) {
                case 1001: // Styles
                    emit stylesRequested();
                    return true;
                case 1002: // Settings
                    emit settingsRequested();
                    return true;
            }
        }
    }
    return false;
}

#endif