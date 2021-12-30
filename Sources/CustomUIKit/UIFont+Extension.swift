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
    
    public class var boldHeading: UIFont {
        return UIFont(name: "HelveticaNeue", size: 18) ?? .systemFont(ofSize: 16)
    }
    
    public class var heading: UIFont {
        return UIFont.systemFont(ofSize: 18.0)
    }
    
    public class var boldSubHeading: UIFont {
        return UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    public class var subhHeading: UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 16) ?? .systemFont(ofSize: 16)
    }
    
    public class var body: UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 14) ?? .systemFont(ofSize: 14)
    }
    
    public class var boldBody: UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: 14) ?? .boldSystemFont(ofSize: 14)
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

extension UIFont {

    public class var boldSFHeading: UIFont! {
        return UIFont(name: "SFProText-Bold", size: 18) ?? .systemFont(ofSize: 18)
    }
    
    public class var boldSFSubHeading: UIFont! {
        return UIFont(name: "SFProText-Bold", size: 16) ?? .systemFont(ofSize: 16)
    }
    
    public class var boldSFRegualarSubHeading: UIFont {
           return UIFont(name: "SFProText-Regular", size: 16) ?? .systemFont(ofSize: 16)
    }
    
    public class var subSFHeading: UIFont {
        return UIFont(name: "SFProText-Light", size: 16) ?? .systemFont(ofSize: 16)
    }
    
    public class var subSFNavigation: UIFont {
        return UIFont(name: "SFProText-Light", size: 17) ?? .systemFont(ofSize: 17)
    }
    
    public class var sfBody: UIFont {
        return UIFont(name: "SFProText-Light", size: 14) ?? .systemFont(ofSize: 14)
    }
    
    public class var sfBoldBody: UIFont {
        return UIFont(name: "SFProText-Bold", size: 14) ?? .boldSystemFont(ofSize: 14)
    }
    
    public class var sfRegularBody: UIFont {
        return UIFont(name: "SFProText-Regular", size: 14) ?? systemFont(ofSize: 14)
    }
    
    public class var sfPageHeading: UIFont {
        return UIFont(name: "SFProText-Bold", size: 26) ?? .boldSystemFont(ofSize: 26)
    }
    
    public class var priceBigHeading: UIFont {
        return UIFont(name: "SFProText-Bold", size: 40) ?? .systemFont(ofSize: 40.0)
    }
}
