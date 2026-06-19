#include <QApplication>
#include <QMainWindow>
#include "squarewidget.h"

#ifdef Q_OS_WIN
#include <windows.h>
#endif

bool showTerminal = false;  // Set to false to suppress the terminal/console window

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    if (!showTerminal) {
        #ifdef Q_OS_WIN
        FreeConsole();
        #endif
    }

    QMainWindow window;
    window.setWindowTitle("Red Square Dragger");

    SquareWidget *squareWidget = new SquareWidget(&window);
    window.setCentralWidget(squareWidget);

    window.showMaximized();

    return app.exec();
}
