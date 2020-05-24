//
//  UIImage+Load.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 24/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(imageNamed: String) {
        self.init(named: imageNamed, in: BundleHelper.currentBundle, compatibleWith: nil)
    }
    
    static var tickMarkImage: UIImage? {
        return UIImage(imageNamed: "tickMark")
    }
    
    static var crossMarkImage: UIImage? {
        return UIImage(imageNamed: "tickMark")
    }
    
    static var wifiImage: UIImage? {
        return UIImage(imageNamed: "wifi")
    }
}

class BundleHelper {
    static var currentBundle: Bundle {
        return Bundle(for: self)
    }
}
