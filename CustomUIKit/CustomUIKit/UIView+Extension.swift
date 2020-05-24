//
//  UIView+Extension.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 03/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import Foundation
import UIKit

public enum IgnoreConstant {
    case top
    case bottom
    case left
    case right
    case none
}

public extension UIView {
    
    public func addSubview(_ subView: UIView, insets: UIEdgeInsets, ignoreConstant: IgnoreConstant = .none) {
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)
        
        switch ignoreConstant {
        case .none:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-left-[subView]-right-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["left": insets.left, "right": insets.right], views: ["subView": subView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[subView]-bottom-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["top": insets.top, "bottom": insets.bottom], views: ["subView": subView]))
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(left)-[subView]-(right)-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["left": insets.left, "right": insets.right], views: ["subView": subView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[subView]-bottom-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["top": insets.top, "bottom": insets.bottom], views: ["subView": subView]))
            
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-left-[subView]-right-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["left": insets.left, "right": insets.right], views: ["subView": subView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[subView]",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["top": insets.top, "bottom": insets.bottom], views: ["subView": subView]))
        case .left:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[subView]-right-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["left": insets.left, "right": insets.right], views: ["subView": subView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[subView]-bottom-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["top": insets.top, "bottom": insets.bottom], views: ["subView": subView]))
        case .right:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-left-[subView]",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["left": insets.left, "right": insets.right], views: ["subView": subView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[subView]-bottom-|",
                                                               options: NSLayoutConstraint.FormatOptions.directionLeadingToTrailing,
                                                               metrics: ["top": insets.top, "bottom": insets.bottom], views: ["subView": subView]))
        }
    }
}

extension UIEdgeInsets {
    static let standardMargin = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
}
