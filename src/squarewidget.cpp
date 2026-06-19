#include "squarewidget.h"
#include <QPainter>
#include <QMouseEvent>

SquareWidget::SquareWidget(QWidget *parent)
    : QWidget(parent), isDragging(false) {
    setFixedSize(400, 300);
    squareRect = QRect(150, 100, 100, 100);
}

void SquareWidget::paintEvent(QPaintEvent *event) {
    Q_UNUSED(event);
    
    QPainter painter(this);
    
    // Fill background with white
    painter.fillRect(rect(), Qt::white);
    
    // Draw blue square
    painter.fillRect(squareRect, Qt::blue);
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
