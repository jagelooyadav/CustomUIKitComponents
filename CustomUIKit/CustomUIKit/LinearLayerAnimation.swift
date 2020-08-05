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
    
    public init(lineWidth: CGFloat, lineColor: UIColor) {
        self.progressLayer.strokeColor = lineColor.cgColor
        self.progressLayer.lineWidth = lineWidth
    }
    
    public func animate(in view: UIView,
                        duration: CGFloat,
                        distanceToCover: CGFloat,
                        completion: (() -> Void)?) {
        self.completion = completion
        view.layer.addSublayer(self.progressLayer)
        self.drawLineFromPoint(start: .zero, toPoint: CGPoint(x: distanceToCover, y: 0.0))
    }
    
    private func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        var time: CGFloat = 10.0
        var distance: CGFloat = 0.0
        self.animate(forTime: &time, timeLapses: &distance, distance: end.x, path: path)
    }
    
    private func animate(forTime second: inout CGFloat,
                         timeLapses: inout CGFloat,
                         distance: CGFloat,
                         path: UIBezierPath) {
        if timeLapses >= second {
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
