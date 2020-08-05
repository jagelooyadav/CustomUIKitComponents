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
    
    public class var boldHeading: UIFont! {
        return UIFont(name: "HelveticaNeue", size: 18)
    }
    
    public class var heading: UIFont {
        return UIFont.systemFont(ofSize: 18.0)
    }
    
    public class var boldSubHeading: UIFont {
        return UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    public class var subhHeading: UIFont! {
        return UIFont(name: "HelveticaNeue-Light", size: 18)
    }
    
    public class var body: UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }
    
    public class var pageHeading: UIFont {
        return UIFont.systemFont(ofSize: 32.0)
    }
    
    public class var bigBrother: UIFont {
        return UIFont.systemFont(ofSize: 40.0)
    }
    
    public class var boldBigBrother: UIFont {
        return UIFont.systemFont(ofSize: 40.0)
    }
}
