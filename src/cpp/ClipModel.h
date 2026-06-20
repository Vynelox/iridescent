#pragma once

#include <QAbstractListModel>
#include <QList>
#include "TimelineClip.h"

class ClipModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        MediaIdRole,
        TrackRole,
        StartFrameRole,
        EndFrameRole,
        SrcInRole,
        SrcOutRole,
        FadesRole,
        NameRole,
        TypeRole
    };
    Q_ENUM(Roles)

    explicit ClipModel(QObject *parent = nullptr);
    
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    
    Q_INVOKABLE void addClip(const QVariantMap &clip);
    Q_INVOKABLE void removeClip(const QString &id);
    Q_INVOKABLE QVariantMap getClip(const QString &id) const;
    Q_INVOKABLE QVariantList clipsForTrack(int track) const;
    Q_INVOKABLE void splitClip(const QString &clipId, int frame);
    Q_INVOKABLE void trimClip(const QString &clipId, int frame, bool latter, bool ripple);
    Q_INVOKABLE void nudgeClips(const QStringList &ids, int delta);
    Q_INVOKABLE void joinClips(const QString &clipAId, const QString &clipBId);
    Q_INVOKABLE void fadeChange(const QString &clipId, const QString &side, int frames);
    Q_INVOKABLE void rollClip(const QString &clipId, int newSrcIn, int newSrcOut);
    Q_INVOKABLE void stepEdge(const QString &clipId, const QStringList &cutBetween, int direction, bool ripple);
    Q_INVOKABLE void clear();
    Q_INVOKABLE int count() const { return m_clips.size(); }
    Q_INVOKABLE int totalFrames() const;

signals:
    void clipsChanged();

private:
    QList<TimelineClip> m_clips;
    int findClipIndex(const QString &id) const;
};