//
//  Appearance.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//  Copyright © 2019 Jageloo Yadav : Group Centre. All rights reserved.
//

import UIKit

struct Appearance {

    static func setUpUIAppearance() {
        
        let appearance = UINavigationBar.appearance()
        
        appearance.tintColor = Color.whiteColour
        appearance.barTintColor = Color.appColour
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldHeading]
    }
}
