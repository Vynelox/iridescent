#pragma once

#include <QString>
#include <QMetaType>
#include "Types.h"

struct MediaItem {
    QString id;
    QString name;
    MediaType type = MediaType::Video;
    QString src;
    int duration = 0; // in frames
    int width = 0;
    int height = 0;
    QString thumbnail;
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        m["id"] = id;
        m["name"] = name;
        m["type"] = static_cast<int>(type);
        m["src"] = src;
        m["duration"] = duration;
        m["width"] = width;
        m["height"] = height;
        m["thumbnail"] = thumbnail;
        return m;
    }
    
    static MediaItem fromVariantMap(const QVariantMap &m) {
        MediaItem item;
        item.id = m["id"].toString();
        item.name = m["name"].toString();
        item.type = static_cast<MediaType>(m["type"].toInt());
        item.src = m["src"].toString();
        item.duration = m["duration"].toInt();
        item.width = m["width"].toInt();
        item.height = m["height"].toInt();
        item.thumbnail = m["thumbnail"].toString();
        return item;
    }
};

Q_DECLARE_METATYPE(MediaItem)