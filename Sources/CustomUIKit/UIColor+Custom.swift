//
//  UIColor+.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//

import UIKit

extension UIColor {
    
    /// The maximum possible value for an RGB value.
    private static let maxColourValue: CGFloat = 255.0
 
    public convenience init(actualRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
        let selfType = type(of: self)
        
        self.init(red: red / selfType.maxColourValue,
                  green: green / selfType.maxColourValue,
                  blue: blue / selfType.maxColourValue,
                  alpha: alpha)
    }
 
    public convenience init(actualColorValue colorValue: CGFloat, alpha: CGFloat = 1.0) {
        self.init(actualRed: colorValue, green: colorValue, blue: colorValue, alpha: alpha)
    }
}
