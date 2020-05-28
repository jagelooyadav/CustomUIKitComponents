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
    public static func setUpUIAppearance() {
        self.setUpUIAppearance(appColor: Color.appColour)
    }
    
    public static func setUpUIAppearance(appColor: UIColor) {
        self.color = appColor
        let appearance = UINavigationBar.appearance()
        
        appearance.tintColor = Color.whiteColour
        appearance.barTintColor = appColor
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldHeading]
    }
}
