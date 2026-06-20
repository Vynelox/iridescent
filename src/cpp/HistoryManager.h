#pragma once

#include <QObject>
#include <QList>
#include <QVariantMap>
#include <functional>
#include "Types.h"

class HistoryManager : public QObject {
    Q_OBJECT

    Q_PROPERTY(bool canUndo READ canUndo NOTIFY canUndoChanged)
    Q_PROPERTY(bool canRedo READ canRedo NOTIFY canRedoChanged)

public:
    explicit HistoryManager(QObject *parent = nullptr);
    
    bool canUndo() const { return !m_undoStack.isEmpty(); }
    bool canRedo() const { return !m_redoStack.isEmpty(); }
    
    Q_INVOKABLE void push(const QVariantMap &snapshot);
    Q_INVOKABLE QVariantMap undo();
    Q_INVOKABLE QVariantMap redo();
    Q_INVOKABLE void clear();

signals:
    void canUndoChanged();
    void canRedoChanged();

private:
    QList<QVariantMap> m_undoStack;
    QList<QVariantMap> m_redoStack;
    static const int MAX_SIZE = 200;
};