//
//  UIImage+Load.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 24/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public extension UIImage {
    
     convenience init?(imageNamed: String) {
        self.init(named: imageNamed, in: BundleHelper.currentBundle, compatibleWith: nil)
    }
    
    static var tickMarkImage: UIImage? {
        return UIImage(imageNamed: "tickMark")
    }
    
    static var untickMarkImage: UIImage? {
        return UIImage(imageNamed: "untickMark")
    }
    
    static var redCheckMark: UIImage? {
           return UIImage(imageNamed: "icon_redx")
    }
    
    static var greenTick: UIImage? {
        return UIImage(imageNamed: "icon_greencheckmark")
    }
    
    static var gradientButton: UIImage? {
           return UIImage(imageNamed: "button")
    }

}

class BundleHelper {
    static var currentBundle: Bundle {
        return Bundle(for: self)
    }
}
