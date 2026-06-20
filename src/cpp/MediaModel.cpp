#include "MediaModel.h"

MediaModel::MediaModel(QObject *parent) : QAbstractListModel(parent) {}

int MediaModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)
    return m_items.size();
}

QVariant MediaModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_items.size()) return QVariant();
    const MediaItem &item = m_items.at(index.row());
    switch (role) {
    case IdRole: return item.id;
    case NameRole: return item.name;
    case TypeRole: return static_cast<int>(item.type);
    case SrcRole: return item.src;
    case DurationRole: return item.duration;
    case WidthRole: return item.width;
    case HeightRole: return item.height;
    case ThumbnailRole: return item.thumbnail;
    default: return QVariant();
    }
}

QHash<int, QByteArray> MediaModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[TypeRole] = "type";
    roles[SrcRole] = "src";
    roles[DurationRole] = "duration";
    roles[WidthRole] = "width";
    roles[HeightRole] = "height";
    roles[ThumbnailRole] = "thumbnail";
    return roles;
}

void MediaModel::addMedia(const QVariantMap &media) {
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(MediaItem::fromVariantMap(media));
    endInsertRows();
}

void MediaModel::removeMedia(const QString &id) {
    for (int i = 0; i < m_items.size(); ++i) {
        if (m_items[i].id == id) {
            beginRemoveRows(QModelIndex(), i, i);
            m_items.removeAt(i);
            endRemoveRows();
            return;
        }
    }
}

QVariantMap MediaModel::getMedia(const QString &id) const {
    for (const auto &item : m_items) {
        if (item.id == id) return item.toVariantMap();
    }
    return QVariantMap();
}

void MediaModel::clear() {
    beginResetModel();
    m_items.clear();
    endResetModel();
}