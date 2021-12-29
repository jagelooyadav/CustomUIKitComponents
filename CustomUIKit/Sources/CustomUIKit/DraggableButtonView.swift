//
//  DraggableButtonView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 05/07/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public protocol DraggableButtonViewConfiguration {
    
    var width: CGFloat { get }
    var horizontalPading: CGFloat { get }
    var topPading: CGFloat { get }
    var bottomPadding: CGFloat { get }
}

public extension DraggableButtonViewConfiguration {
    var width: CGFloat { return 56.0 }
    var horizontalPading: CGFloat { return 10.0 }
    var topPading: CGFloat { return 0.0 }
    var bottomPadding: CGFloat { return 70.0 }
}

public class DraggableButtonView: UIView {
    
    private var updatedFrame = CGRect.zero

    private var configuation: DraggableButtonViewConfiguration

    public init(withConfiguration configuration: DraggableButtonViewConfiguration) {
        self.configuation = configuration
        super.init(frame: .zero)
        self.addDraggableGuesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showInView(_ view: UIView, atPosition position: CGPoint? = nil) {
        view.addSubview(self)
        let postionF = CGPoint.init(x: position?.x ?? view.frame.size.width - self.configuation.horizontalPading - self.configuation.width,
                                   y: position?.y ?? view.frame.size.height - self.configuation.bottomPadding - self.configuation.width)
        let floatingFrame = CGRect.init(origin: postionF, size: CGSize.init(width: self.configuation.width, height: self.configuation.width))
        self.frame = floatingFrame
        self.backgroundColor = .red
        self.updatedFrame = floatingFrame
        self.isUserInteractionEnabled = true
    }
    
    func addDraggableGuesture() {
        let guesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag(_:)))
        self.addGestureRecognizer(guesture)
        
        let tapGuesture = UITapGestureRecognizer.init(target: self, action: #selector(self.tap))
        self.addGestureRecognizer(tapGuesture)
    }
    
    @objc private func drag(_ sender: UIPanGestureRecognizer) {
        guard let targetView = sender.view, let superView = targetView.superview else { return }
        
        let translation = sender.translation(in: superView)
        let newX = self.updatedFrame.origin.x + translation.x
        let newY = self.updatedFrame.origin.x + translation.y
        
        var calculatedFrame = CGRect.init(x: newX, y: newY, width: self.updatedFrame.width, height: self.updatedFrame.width)
       
        print("calculatedFrame === \(calculatedFrame)")
        switch sender.state {
        case .began:
            self.updatedFrame = targetView.convert(targetView.frame, to: superView)
        case .changed:
            calculatedFrame = self.reCalculate(frame: calculatedFrame, superView: superView)
            if superView.frame.contains(calculatedFrame) {
                self.frame = calculatedFrame
            }
        case .failed:
            self.frame = self.updatedFrame
            
        default:
            break
        }
        
    }
    
    func reCalculate(frame: CGRect, superView: UIView) -> CGRect {
        
        var calculatedFrame = frame
        print("calculatedFrame === \(calculatedFrame)")
        if frame.origin.x < 0 {
            calculatedFrame.origin.x = 0
        } else if frame.maxX > superView.frame.maxX {
            calculatedFrame.origin.x = superView.frame.maxX - calculatedFrame.size.width
        } else if frame.origin.y < 0 {
            calculatedFrame.origin.y = 0
        } else if frame.maxY > superView.frame.maxY {
            calculatedFrame.origin.y = superView.frame.maxY - calculatedFrame.size.height
        }
        return calculatedFrame
    }
    
    @objc private func tap() {
        
    }
}
