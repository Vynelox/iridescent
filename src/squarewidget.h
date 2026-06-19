#ifndef SQUAREWIDGET_H
#define SQUAREWIDGET_H

#include <QWidget>

class SquareWidget : public QWidget {
public:
    explicit SquareWidget(QWidget *parent = nullptr);

protected:
    void paintEvent(QPaintEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;

private:
    bool isDragging;
    QPoint dragOffset;
    QRect squareRect;
};

#endif // SQUAREWIDGET_H
