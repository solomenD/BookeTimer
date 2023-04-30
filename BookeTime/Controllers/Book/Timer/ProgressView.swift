//
//  ProgressView.swift
//  BookeTime
//
//  Created by Solomon  on 26.01.2023.
//

import UIKit

//extension TimerView {
//    final
class ProgressView: UIView {
    func drawProgress(with percent: CGFloat, circleLayers: Bool) {
                    layer.sublayers?.removeAll()
            
            let circleFrame = UIScreen.main.bounds.width - (15 + 40) * 2
            let radius = circleFrame / 2
            let center = CGPoint(x: radius, y: radius)
            let startAngle = -CGFloat.pi * 7 / 6
            let endAngle = CGFloat.pi * 1 / 6
            
            let circlePath = UIBezierPath(arcCenter: center,
                                          radius: radius,
                                          startAngle: startAngle,
                                          endAngle: endAngle,
                                          clockwise: true)
            let defaultcircleLayer = CAShapeLayer()
            defaultcircleLayer.path = circlePath.cgPath
            defaultcircleLayer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            defaultcircleLayer.lineWidth = 20
            defaultcircleLayer.strokeEnd = 1
            defaultcircleLayer.fillColor = UIColor.clear.cgColor
            defaultcircleLayer.lineCap = .round
            
            let circleLayer = CAShapeLayer()
            circleLayer.path = circlePath.cgPath
            circleLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            circleLayer.lineWidth = 20
            circleLayer.strokeEnd = percent
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.lineCap = .round
            
            let dotAngle = CGFloat.pi * (7 / 6 - (8 / 6 * percent))
            
            let dotPoint = CGPoint(x: cos(-dotAngle) * radius + center.x,
                                   y: sin(-dotAngle) * radius + center.y)
            
            let dotPath = UIBezierPath()
            dotPath.move(to: dotPoint)
            dotPath.addLine(to: dotPoint)
            
            let bigDotLayer = CAShapeLayer()
            bigDotLayer.path = dotPath.cgPath
            bigDotLayer.fillColor = UIColor.clear.cgColor
            bigDotLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            bigDotLayer.lineCap = .round
            bigDotLayer.lineWidth = 20
            
            let dotLayer = CAShapeLayer()
            dotLayer.path = dotPath.cgPath
            dotLayer.fillColor = UIColor.clear.cgColor
            dotLayer.strokeColor = UIColor.white.cgColor
            dotLayer.lineCap = .round
            dotLayer.lineWidth = 10
            
            let barsFrame = UIScreen.main.bounds.width - (15 + 40 + 25) * 2
            let barRadius = barsFrame / 2
            
            let barsPath = UIBezierPath(arcCenter: center,
                                        radius: barRadius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
            
            let barsLayer = CAShapeLayer()
            barsLayer.path = barsPath.cgPath
            barsLayer.fillColor = UIColor.clear.cgColor
            barsLayer.strokeColor = UIColor.clear.cgColor
            barsLayer.lineWidth = 6
            
            let startBarRadius = barRadius - barsLayer.lineWidth / 0.5
            let endBarRadius = startBarRadius + 6
            
            var angle: CGFloat = 7 / 6
            (1...9).forEach { _ in
                let barAngle = CGFloat.pi * angle
                let startBarPoint = CGPoint(x: cos(-barAngle) * startBarRadius + center.x,
                                            y: sin(-barAngle) * startBarRadius + center.y
                                            )
                let endBarPoint = CGPoint(x: cos(-barAngle) * endBarRadius + center.x,
                                            y: sin(-barAngle) * endBarRadius + center.y
                                            )
                let barPath = UIBezierPath()
                barPath.move(to: startBarPoint)
                barPath.addLine(to: endBarPoint)
                
                let barLayer = CAShapeLayer()
                barLayer.path = barPath.cgPath
                barLayer.fillColor = UIColor.clear.cgColor
                if circleLayers == true { barLayer.strokeColor = angle >= (7 / 6 - (8 / 6 * percent))
                    ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) } else {
                        barLayer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    }
                barLayer.lineCap = .round
                barLayer.lineWidth = 4
                
                barsLayer.addSublayer(barLayer)
                
                angle -= 1 / 6
            }

            layer.addSublayer(defaultcircleLayer)
            layer.addSublayer(circleLayer)
            layer.addSublayer(barsLayer)
        if circleLayers == true {
            layer.addSublayer(bigDotLayer)
            layer.addSublayer(dotLayer)
        } else { return }
        }
    }
//}
