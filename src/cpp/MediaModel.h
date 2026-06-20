#pragma once

#include <QAbstractListModel>
#include <QList>
#include "MediaItem.h"

class MediaModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        TypeRole,
        SrcRole,
        DurationRole,
        WidthRole,
        HeightRole,
        ThumbnailRole
    };
    Q_ENUM(Roles)

    explicit MediaModel(QObject *parent = nullptr);
    
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    
    Q_INVOKABLE void addMedia(const QVariantMap &media);
    Q_INVOKABLE void removeMedia(const QString &id);
    Q_INVOKABLE QVariantMap getMedia(const QString &id) const;
    Q_INVOKABLE void clear();
    Q_INVOKABLE int count() const { return m_items.size(); }

private:
    QList<MediaItem> m_items;
};