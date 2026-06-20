#pragma once

#include <QString>
#include <QMetaType>
#include "Types.h"

struct Track {
    QString id;
    TrackType type = TrackType::Video;
    QString label;
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        m["id"] = id;
        m["type"] = static_cast<int>(type);
        m["label"] = label;
        return m;
    }
    
    static Track fromVariantMap(const QVariantMap &m) {
        Track t;
        t.id = m["id"].toString();
        t.type = static_cast<TrackType>(m["type"].toInt());
        t.label = m["label"].toString();
        return t;
    }
};

Q_DECLARE_METATYPE(Track)