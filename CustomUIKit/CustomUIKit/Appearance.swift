//
//  Appearance.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//  Copyright © 2019 Jageloo Yadav : Group Centre. All rights reserved.
//

import UIKit

public struct Appearance {
    public static var color: UIColor = Color.appColour
    public static var tintColor: UIColor = Color.whiteColour
    
    public static func setUpUIAppearance() {
        self.setUpUIAppearance(appColor: Color.appColour)
    }
    
    public static func setUpUIAppearance(appColor: UIColor, tintColor: UIColor = .white) {
        self.color = appColor
        self.tintColor = tintColor
        let appearance = UINavigationBar.appearance()
        
        appearance.tintColor = Color.whiteColour
        
        appearance.barTintColor = appColor
        appearance.backgroundColor = appColor
        let image = UIImage.init(color: color, size: CGSize.init(width: 1000.0, height: 100.0))
        appearance.setBackgroundImage(image, for: .default)
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor, NSAttributedString.Key.font: UIFont.boldHeading]
    }
}
