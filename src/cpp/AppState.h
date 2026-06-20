#pragma once

#include <QObject>
#include <QStringList>
#include <QTimer>
#include "Types.h"

class AppState : public QObject {
    Q_OBJECT

    Q_PROPERTY(int playhead READ playhead WRITE setPlayhead NOTIFY playheadChanged)
    Q_PROPERTY(bool playing READ playing WRITE setPlaying NOTIFY playingChanged)
    Q_PROPERTY(QStringList selectedIds READ selectedIds WRITE setSelectedIds NOTIFY selectedIdsChanged)
    Q_PROPERTY(double zoom READ zoom WRITE setZoom NOTIFY zoomChanged)
    Q_PROPERTY(int totalFrames READ totalFrames NOTIFY totalFramesChanged)

public:
    explicit AppState(QObject *parent = nullptr);
    
    int playhead() const { return m_playhead; }
    void setPlayhead(int v);
    
    bool playing() const { return m_playing; }
    void setPlaying(bool v);
    
    QStringList selectedIds() const { return m_selectedIds; }
    void setSelectedIds(const QStringList &v);
    
    double zoom() const { return m_zoom; }
    void setZoom(double v);
    
    int totalFrames() const { return m_totalFrames; }
    
    Q_INVOKABLE QString formatTimecode(int frames) const;
    Q_INVOKABLE double framesToSeconds(int frames) const;
    Q_INVOKABLE int secondsToFrames(double seconds) const;
    Q_INVOKABLE QString generateId() const;
    
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void togglePlay();
    Q_INVOKABLE void seek(int frame);
    Q_INVOKABLE void selectClip(const QString &id, bool multi);
    
    void setTotalFrames(int v);

signals:
    void playheadChanged();
    void playingChanged();
    void selectedIdsChanged();
    void zoomChanged();
    void totalFramesChanged();

private:
    int m_playhead = 0;
    bool m_playing = false;
    QStringList m_selectedIds;
    double m_zoom = 1.0;
    int m_totalFrames = 0;
    QTimer *m_playTimer = nullptr;
};