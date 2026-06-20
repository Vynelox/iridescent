#include "AppState.h"
#include <QRandomGenerator>

AppState::AppState(QObject *parent) : QObject(parent) {
    m_playTimer = new QTimer(this);
    m_playTimer->setInterval(1000 / 30); // 30 FPS
    connect(m_playTimer, &QTimer::timeout, this, [this]() {
        setPlayhead(m_playhead + 1);
    });
}

void AppState::setPlayhead(int v) {
    if (m_playhead != v) {
        m_playhead = v;
        emit playheadChanged();
    }
}

void AppState::setPlaying(bool v) {
    if (m_playing != v) {
        m_playing = v;
        emit playingChanged();
        if (v) {
            m_playTimer->start();
        } else {
            m_playTimer->stop();
        }
    }
}

void AppState::setSelectedIds(const QStringList &v) {
    if (m_selectedIds != v) {
        m_selectedIds = v;
        emit selectedIdsChanged();
    }
}

void AppState::setZoom(double v) {
    if (m_zoom != v) {
        m_zoom = v;
        emit zoomChanged();
    }
}

void AppState::setTotalFrames(int v) {
    if (m_totalFrames != v) {
        m_totalFrames = v;
        emit totalFramesChanged();
    }
}

QString AppState::formatTimecode(int frames) const {
    int totalSeconds = frames / 30;
    int f = frames % 30;
    int s = totalSeconds % 60;
    int m = (totalSeconds / 60) % 60;
    int h = totalSeconds / 3600;
    return QString("%1:%2:%3:%4")
        .arg(h, 2, 10, QChar('0'))
        .arg(m, 2, 10, QChar('0'))
        .arg(s, 2, 10, QChar('0'))
        .arg(f, 2, 10, QChar('0'));
}

double AppState::framesToSeconds(int frames) const {
    return static_cast<double>(frames) / 30.0;
}

int AppState::secondsToFrames(double seconds) const {
    return qRound(seconds * 30.0);
}

QString AppState::generateId() const {
    return QString::number(QRandomGenerator::global()->generate(), 36).left(8);
}

void AppState::play() { setPlaying(true); }
void AppState::pause() { setPlaying(false); }
void AppState::togglePlay() { setPlaying(!m_playing); }

void AppState::seek(int frame) {
    setPlayhead(qMax(0, frame));
    if (m_playhead >= m_totalFrames) {
        setPlaying(false);
    }
}

void AppState::selectClip(const QString &id, bool multi) {
    if (multi) {
        QStringList ids = m_selectedIds;
        if (ids.contains(id)) {
            ids.removeAll(id);
        } else {
            ids.append(id);
        }
        setSelectedIds(ids);
    } else {
        setSelectedIds(QStringList{id});
    }
}

void AppState::setPlayneedleParams(const QVariantMap &v) {
    PlayneedleParams p = PlayneedleParams::fromVariantMap(v);
    if (!(p == m_playneedleParams)) {
        m_playneedleParams = p;
        emit playneedleParamsChanged();
    }
}

void AppState::resetPlayneedleParam(const QString &key) {
    PlayneedleParams defaults;
    QVariantMap current = m_playneedleParams.toVariantMap();
    QVariantMap defaultsMap = defaults.toVariantMap();
    if (current.contains(key) && defaultsMap.contains(key)) {
        current[key] = defaultsMap[key];
        setPlayneedleParams(current);
    }
}
