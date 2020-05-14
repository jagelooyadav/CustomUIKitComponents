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
    
    /**
     Creates a colour with actual red, green, blue and alpha values.
     
     Red, green and blue should be provided as a value beeen `0` and `255`.
     
     - parameters:
     - red: The actual red value.
     - green: The actual green value.
     - blue: The actual blue value.
     - alpha: The alpha value, beeen `0` and `1`. Defaults to `1`.
     */
    public convenience init(actualRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
        let selfType = type(of: self)
        
        self.init(red: red / selfType.maxColourValue,
                  green: green / selfType.maxColourValue,
                  blue: blue / selfType.maxColourValue,
                  alpha: alpha)
    }
    
    /**
     Creates a colour with an actual RGB value, which is applied to red, green and blue.
     
     The value should be provided beeen `0` and `255`.
     
     For example, `200` will produce a colour with `200` red, `200` green and `200` blue.
     - parameters:
     - colorValue: The actual value to be used for red, green and blue.
     - alpha: The alpha value, beeen `0` and `1`. Defaults to `1`.
     */
    public convenience init(actualColorValue colorValue: CGFloat, alpha: CGFloat = 1.0) {
        self.init(actualRed: colorValue, green: colorValue, blue: colorValue, alpha: alpha)
    }
}
