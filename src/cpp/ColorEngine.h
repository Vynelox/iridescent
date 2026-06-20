#pragma once

#include <QColor>
#include <QString>
#include <QVector>
#include <cmath>
#include "Types.h"

class ColorEngine {
public:
    static QColor hexToRgb(const QString &hex) {
        QString h = hex;
        if (h.startsWith("#")) h = h.mid(1);
        if (h.length() == 3) {
            h = QString(h[0]) + h[0] + h[1] + h[1] + h[2] + h[2];
        }
        bool ok;
        int v = h.toInt(&ok, 16);
        if (!ok) return QColor(0, 0, 0);
        return QColor((v >> 16) & 0xFF, (v >> 8) & 0xFF, v & 0xFF);
    }
    
    static QString rgbToHex(int r, int g, int b) {
        return QString("#%1%2%3")
            .arg(qBound(0, r, 255), 2, 16, QChar('0'))
            .arg(qBound(0, g, 255), 2, 16, QChar('0'))
            .arg(qBound(0, b, 255), 2, 16, QChar('0'));
    }
    
    static QColor hslToRgb(double h, double s, double l) {
        double c = (1.0 - std::abs(2.0 * l - 1.0)) * s;
        double hh = h / 60.0;
        double x = c * (1.0 - std::abs(std::fmod(hh, 2.0) - 1.0));
        double r1 = 0, g1 = 0, b1 = 0;
        if (hh >= 0 && hh < 1)       { r1 = c; g1 = x; b1 = 0; }
        else if (hh >= 1 && hh < 2)  { r1 = x; g1 = c; b1 = 0; }
        else if (hh >= 2 && hh < 3)  { r1 = 0; g1 = c; b1 = x; }
        else if (hh >= 3 && hh < 4)  { r1 = 0; g1 = x; b1 = c; }
        else if (hh >= 4 && hh < 5)  { r1 = x; g1 = 0; b1 = c; }
        else                          { r1 = c; g1 = 0; b1 = x; }
        double m = l - c / 2.0;
        return QColor(
            qRound((r1 + m) * 255),
            qRound((g1 + m) * 255),
            qRound((b1 + m) * 255)
        );
    }
    
    static QVector<double> rgbToHsl(int r, int g, int b) {
        double rd = r / 255.0;
        double gd = g / 255.0;
        double bd = b / 255.0;
        double max = std::max({rd, gd, bd});
        double min = std::min({rd, gd, bd});
        double h = 0, s = 0;
        double l = (max + min) / 2.0;
        if (max != min) {
            double d = max - min;
            s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
            if (max == rd)      h = (gd - bd) / d + (gd < bd ? 6.0 : 0.0);
            else if (max == gd) h = (bd - rd) / d + 2.0;
            else                 h = (rd - gd) / d + 4.0;
            h *= 60.0;
        }
        return {h, s, l};
    }
    
    static QString hslToHex(double h, double s, double l) {
        QColor c = hslToRgb(h, s, l);
        return rgbToHex(c.red(), c.green(), c.blue());
    }
    
    static QVector<double> hexToHsl(const QString &hex) {
        QColor c = hexToRgb(hex);
        return rgbToHsl(c.red(), c.green(), c.blue());
    }
    
    static QString normalizeColor(const QString &raw) {
        if (raw.isEmpty()) return "#000000";
        QString v = raw.trimmed();
        if (v.startsWith("#")) {
            if (v.length() == 4) {
                return QString("#%1%1%2%2%3%3").arg(v[1]).arg(v[2]).arg(v[3]);
            }
            return v;
        }
        if (v.startsWith("rgb")) {
            QStringList parts = v.mid(v.indexOf('(') + 1, v.indexOf(')') - v.indexOf('(') - 1).split(",");
            if (parts.size() >= 3) {
                return rgbToHex(parts[0].trimmed().toInt(), parts[1].trimmed().toInt(), parts[2].trimmed().toInt());
            }
        }
        return "#000000";
    }
};