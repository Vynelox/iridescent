#pragma once

#include <QString>
#include <QVector>
#include <cmath>
#include "Types.h"

class PlayneedleEngine {
public:
    static double evaluateF(double x, const PlayneedleParams &p) {
        // Ribbon component: h_r * sigmoid * (1-t) + t
        double sigmoid = 1.0 / (1.0 + std::exp(p.k * (x - p.j)));
        double ribbon = p.h_r * sigmoid * (1.0 - p.t) + p.t;
        
        // Button component
        double buttonCenter = p.v_o * (1.0 - M_PI / p.s);
        double buttonArg = p.s * (x - buttonCenter);
        double buttonSin = std::sin(buttonArg);
        double buttonShape = buttonSin * buttonSin;
        
        // Button window: ceil(-0.1 * (x - buttonCenter) * ((x - buttonCenter) - π/s))
        double dx = x - buttonCenter;
        double windowArg = -0.1 * dx * (dx - M_PI / p.s);
        double buttonWindow = std::ceil(windowArg);
        
        double button = p.h_b * (1.0 - p.t) * buttonShape * buttonWindow;
        
        return ribbon + button;
    }
    
    static QString generateSvgPath(int height, int maxWidth, const PlayneedleParams &p) {
        const int steps = 200;
        double halfMaxW = maxWidth / 2.0;
        
        QStringList leftPoints, rightPoints;
        
        for (int i = 0; i <= steps; i++) {
            double x = static_cast<double>(i) / steps;
            double y = x * height;
            double widthFactor = evaluateF(x, p);
            double halfWidth = widthFactor * halfMaxW;
            
            leftPoints.append(QString("%1 %2").arg(halfMaxW - halfWidth, 0, 'f', 2).arg(y, 0, 'f', 2));
            rightPoints.append(QString("%1 %2").arg(halfMaxW + halfWidth, 0, 'f', 2).arg(y, 0, 'f', 2));
        }
        
        QString path = "M " + leftPoints[0];
        for (int i = 1; i < leftPoints.size(); i++) {
            path += " L " + leftPoints[i];
        }
        for (int i = rightPoints.size() - 1; i >= 0; i--) {
            path += " L " + rightPoints[i];
        }
        path += " Z";
        
        return path;
    }
};