#include "HistoryManager.h"

HistoryManager::HistoryManager(QObject *parent) : QObject(parent) {}

void HistoryManager::push(const QVariantMap &snapshot) {
    m_undoStack.append(snapshot);
    if (m_undoStack.size() > MAX_SIZE) m_undoStack.removeFirst();
    m_redoStack.clear();
    emit canUndoChanged();
    emit canRedoChanged();
}

QVariantMap HistoryManager::undo() {
    if (m_undoStack.isEmpty()) return QVariantMap();
    QVariantMap state = m_undoStack.last();
    m_undoStack.removeLast();
    emit canUndoChanged();
    emit canRedoChanged();
    return state;
}

QVariantMap HistoryManager::redo() {
    if (m_redoStack.isEmpty()) return QVariantMap();
    QVariantMap state = m_redoStack.last();
    m_redoStack.removeLast();
    emit canUndoChanged();
    emit canRedoChanged();
    return state;
}

void HistoryManager::clear() {
    m_undoStack.clear();
    m_redoStack.clear();
    emit canUndoChanged();
    emit canRedoChanged();
}