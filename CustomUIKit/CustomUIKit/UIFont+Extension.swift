//
//  UIFont+Extension.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 04/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class var boldHeading: UIFont {
        return UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    class var heading: UIFont {
        return UIFont.systemFont(ofSize: 18.0)
    }
    
    class var boldSubHeading: UIFont {
        return UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    class var subhHeading: UIFont {
        return UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    class var body: UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }
    
    class var bigBrother: UIFont {
        return UIFont.systemFont(ofSize: 40.0)
    }
    
    class var boldBigBrother: UIFont {
        return UIFont.systemFont(ofSize: 40.0)
    }
}
