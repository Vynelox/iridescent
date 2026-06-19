#include "squarewidget.h"
#include <QPainter>
#include <QMouseEvent>

SquareWidget::SquareWidget(QWidget *parent)
    : QWidget(parent), isDragging(false) {
    squareRect = QRect(100, 100, 100, 100);
}

void SquareWidget::paintEvent(QPaintEvent *event) {
    Q_UNUSED(event);
    
    QPainter painter(this);
    
    // Fill background with white
    painter.fillRect(rect(), Qt::white);
    
    // Draw green square
    painter.fillRect(squareRect, Qt::green);

    // Draw "Hello World" text in top-left corner
    painter.setPen(Qt::black);
    painter.setFont(QFont("Arial", 16));
    painter.drawText(QPoint(10, 25), "Hello World");
}

void SquareWidget::mousePressEvent(QMouseEvent *event) {
    if (event->button() == Qt::LeftButton && squareRect.contains(event->pos())) {
        isDragging = true;
        dragOffset = event->pos() - squareRect.topLeft();
        setCursor(Qt::ClosedHandCursor);
    }
}

void SquareWidget::mouseMoveEvent(QMouseEvent *event) {
    if (isDragging) {
        squareRect.moveTopLeft(event->pos() - dragOffset);
        update();
    }
}

void SquareWidget::mouseReleaseEvent(QMouseEvent *event) {
    if (event->button() == Qt::LeftButton && isDragging) {
        isDragging = false;
        unsetCursor();
    }
}

void SquareWidget::keyPressEvent(QKeyEvent *event) {
    if (event->key() == Qt::Key_F1) {
        QWidget *parentWin = window();
        if (parentWin) {
            if (parentWin->isFullScreen()) {
                parentWin->showMaximized();
            } else {
                parentWin->showFullScreen();
            }
        }
    }
}
