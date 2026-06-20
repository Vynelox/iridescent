#pragma once

#include <QString>
#include <QMetaType>
#include "Types.h"

struct Fade {
    int in = 0;   // frames
    int out = 0;  // frames
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        m["in"] = in;
        m["out"] = out;
        return m;
    }
    
    static Fade fromVariantMap(const QVariantMap &m) {
        Fade f;
        f.in = m["in"].toInt();
        f.out = m["out"].toInt();
        return f;
    }
};

struct TimelineClip {
    QString id;
    QString mediaId;
    int track = 0;
    int startFrame = 0;
    int endFrame = 0;
    int srcIn = 0;
    int srcOut = 0;
    Fade fades;
    QString name;
    MediaType type = MediaType::Video;
    
    QVariantMap toVariantMap() const {
        QVariantMap m;
        m["id"] = id;
        m["mediaId"] = mediaId;
        m["track"] = track;
        m["startFrame"] = startFrame;
        m["endFrame"] = endFrame;
        m["srcIn"] = srcIn;
        m["srcOut"] = srcOut;
        m["fades"] = fades.toVariantMap();
        m["name"] = name;
        m["type"] = static_cast<int>(type);
        return m;
    }
    
    static TimelineClip fromVariantMap(const QVariantMap &m) {
        TimelineClip c;
        c.id = m["id"].toString();
        c.mediaId = m["mediaId"].toString();
        c.track = m["track"].toInt();
        c.startFrame = m["startFrame"].toInt();
        c.endFrame = m["endFrame"].toInt();
        c.srcIn = m["srcIn"].toInt();
        c.srcOut = m["srcOut"].toInt();
        c.fades = Fade::fromVariantMap(m["fades"].toMap());
        c.name = m["name"].toString();
        c.type = static_cast<MediaType>(m["type"].toInt());
        return c;
    }
};

Q_DECLARE_METATYPE(TimelineClip)
Q_DECLARE_METATYPE(Fade)