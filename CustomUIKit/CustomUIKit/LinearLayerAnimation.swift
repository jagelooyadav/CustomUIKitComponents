//
//  LinearLayerAnimation.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 05/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class LinearLayerAnimation {
    
    private let progressLayer = CAShapeLayer()
    private var completion: (() -> Void)?
    
    var stopAnimation = false
    
    public init(lineWidth: CGFloat, lineColor: UIColor) {
        self.progressLayer.strokeColor = lineColor.cgColor
        self.progressLayer.lineWidth = lineWidth
    }
    
    public func animate(in view: UIView,
                        duration: CGFloat,
                        distanceToCover: CGFloat,
                        completion: (() -> Void)?) {
        self.completion = completion
        stopAnimation = false
        view.layer.addSublayer(self.progressLayer)
        self.drawLineFromPoint(start: .zero, toPoint: CGPoint(x: distanceToCover, y: 0.0), duration: duration)
    }
    
    public func removeAnimationLayer() {
        self.progressLayer.removeFromSuperlayer()
        self.progressLayer.path = nil
        stopAnimation = true
    }
    
    private func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, duration: CGFloat) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        var time: CGFloat = duration
        var distance: CGFloat = 0.0
        self.animate(forTime: &time, timeLapses: &distance, distance: end.x, path: path)
    }
    
    private func animate(forTime second: inout CGFloat,
                         timeLapses: inout CGFloat,
                         distance: CGFloat,
                         path: UIBezierPath) {
        if timeLapses >= second, !stopAnimation {
            self.completion?()
            return
        }
        timeLapses += 0.1
        
        let distanceCovered = timeLapses * distance / second
        
        let endPoint = CGPoint.init(x: distanceCovered, y: 0)
        path.addLine(to: endPoint)
        var ss = second
        var dd = timeLapses
        self.progressLayer.path = path.cgPath
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.animate(forTime: &ss, timeLapses: &dd, distance: distance, path: path)
        }
    }
}
