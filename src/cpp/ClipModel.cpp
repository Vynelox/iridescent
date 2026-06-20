#include "ClipModel.h"
#include <QRandomGenerator>

ClipModel::ClipModel(QObject *parent) : QAbstractListModel(parent) {}

int ClipModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent) return m_clips.size();
}

QVariant ClipModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_clips.size()) return QVariant();
    const TimelineClip &c = m_clips.at(index.row());
    switch (role) {
    case IdRole: return c.id;
    case MediaIdRole: return c.mediaId;
    case TrackRole: return c.track;
    case StartFrameRole: return c.startFrame;
    case EndFrameRole: return c.endFrame;
    case SrcInRole: return c.srcIn;
    case SrcOutRole: return c.srcOut;
    case FadesRole: return c.fades.toVariantMap();
    case NameRole: return c.name;
    case TypeRole: return static_cast<int>(c.type);
    default: return QVariant();
    }
}

QHash<int, QByteArray> ClipModel::roleNames() const {
    QHash<int, QByteArray> r;
    r[IdRole]="id"; r[MediaIdRole]="mediaId"; r[TrackRole]="track";
    r[StartFrameRole]="startFrame"; r[EndFrameRole]="endFrame";
    r[SrcInRole]="srcIn"; r[SrcOutRole]="srcOut"; r[FadesRole]="fades";
    r[NameRole]="name"; r[TypeRole]="type";
    return r;
}

void ClipModel::addClip(const QVariantMap &clip) {
    beginInsertRows(QModelIndex(), m_clips.size(), m_clips.size());
    m_clips.append(TimelineClip::fromVariantMap(clip));
    endInsertRows();
    emit clipsChanged();
}

void ClipModel::removeClip(const QString &id) {
    int i = findClipIndex(id);
    if (i >= 0) { beginRemoveRows(QModelIndex(), i, i); m_clips.removeAt(i); endRemoveRows(); emit clipsChanged(); }
}

QVariantMap ClipModel::getClip(const QString &id) const {
    int i = findClipIndex(id);
    return (i >= 0) ? m_clips[i].toVariantMap() : QVariantMap();
}

QVariantList ClipModel::clipsForTrack(int track) const {
    QVariantList result;
    for (const auto &c : m_clips) { if (c.track == track) result.append(c.toVariantMap()); }
    return result;
}

void ClipModel::splitClip(const QString &clipId, int frame) {
    int i = findClipIndex(clipId);
    if (i < 0 || frame <= m_clips[i].startFrame || frame >= m_clips[i].endFrame) return;
    TimelineClip clip = m_clips[i];
    int relFrame = frame - clip.startFrame;
    TimelineClip part1 = clip;
    part1.endFrame = frame;
    part1.srcOut = clip.srcIn + relFrame;
    part1.fades.out = 0;
    TimelineClip part2 = clip;
    part2.id = QString::number(QRandomGenerator::global()->generate(), 36).left(8);
    part2.startFrame = frame;
    part2.srcIn = clip.srcIn + relFrame;
    part2.fades.in = 0;
    m_clips[i] = part1;
    beginInsertRows(QModelIndex(), i+1, i+1);
    m_clips.insert(i+1, part2);
    endInsertRows();
    emit dataChanged(index(i), index(i));
    emit clipsChanged();
}

void ClipModel::trimClip(const QString &clipId, int frame, bool latter, bool ripple) {
    Q_UNUSED(ripple)
    int i = findClipIndex(clipId);
    if (i < 0) return;
    if (latter) {
        m_clips[i].endFrame = frame;
        m_clips[i].srcOut = m_clips[i].srcIn + (frame - m_clips[i].startFrame);
    } else {
        m_clips[i].startFrame = frame;
        m_clips[i].srcIn = m_clips[i].srcIn + (frame - m_clips[i].startFrame);
    }
    emit dataChanged(index(i), index(i));
    emit clipsChanged();
}

void ClipModel::nudgeClips(const QStringList &ids, int delta) {
    for (const QString &id : ids) {
        int i = findClipIndex(id);
        if (i >= 0) {
            m_clips[i].startFrame = qMax(0, m_clips[i].startFrame + delta);
            m_clips[i].endFrame = m_clips[i].startFrame + (m_clips[i].endFrame - m_clips[i].startFrame);
            emit dataChanged(index(i), index(i));
        }
    }
    emit clipsChanged();
}

void ClipModel::joinClips(const QString &clipAId, const QString &clipBId) {
    int a = findClipIndex(clipAId), b = findClipIndex(clipBId);
    if (a < 0 || b < 0 || m_clips[a].mediaId != m_clips[b].mediaId) return;
    m_clips[a].endFrame = m_clips[b].endFrame;
    m_clips[a].srcOut = m_clips[b].srcOut;
    m_clips[a].fades.out = m_clips[b].fades.out;
    if (b > a) { beginRemoveRows(QModelIndex(), b, b); m_clips.removeAt(b); endRemoveRows(); }
    else { beginRemoveRows(QModelIndex(), a, a); m_clips.removeAt(a); endRemoveRows(); }
    emit clipsChanged();
}

void ClipModel::fadeChange(const QString &clipId, const QString &side, int frames) {
    int i = findClipIndex(clipId);
    if (i < 0) return;
    int maxFade = (m_clips[i].endFrame - m_clips[i].startFrame) / 2;
    int val = qBound(0, frames, maxFade);
    if (side == "in") m_clips[i].fades.in = val;
    else m_clips[i].fades.out = val;
    emit dataChanged(index(i), index(i));
    emit clipsChanged();
}

void ClipModel::rollClip(const QString &clipId, int newSrcIn, int newSrcOut) {
    int i = findClipIndex(clipId);
    if (i < 0) return;
    m_clips[i].srcIn = newSrcIn;
    m_clips[i].srcOut = newSrcOut;
    emit dataChanged(index(i), index(i));
    emit clipsChanged();
}

void ClipModel::stepEdge(const QString &clipId, const QStringList &cutBetween, int direction, bool ripple) {
    Q_UNUSED(ripple)
    if (!cutBetween.isEmpty()) {
        int a = findClipIndex(cutBetween[0]);
        int b = findClipIndex(cutBetween[1]);
        if (a >= 0) { m_clips[a].endFrame += direction; m_clips[a].srcOut += direction; emit dataChanged(index(a), index(a)); }
        if (b >= 0) { m_clips[b].startFrame += direction; m_clips[b].srcIn += direction; emit dataChanged(index(b), index(b)); }
    } else if (!clipId.isEmpty()) {
        int i = findClipIndex(clipId);
        if (i >= 0) { m_clips[i].endFrame += direction; m_clips[i].srcOut += direction; emit dataChanged(index(i), index(i)); }
    }
    emit clipsChanged();
}

void ClipModel::clear() { beginResetModel(); m_clips.clear(); endResetModel(); emit clipsChanged(); }

int ClipModel::totalFrames() const {
    int max = 0;
    for (const auto &c : m_clips) max = qMax(max, c.endFrame);
    return max;
}

int ClipModel::findClipIndex(const QString &id) const {
    for (int i = 0; i < m_clips.size(); ++i) { if (m_clips[i].id == id) return i; }
    return -1;
}