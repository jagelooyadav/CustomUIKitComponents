//
//  AmolTabBarControllerViewController.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 01/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

open class AmolTabBarControllerViewController: UITabBarController {
    
    private let gradientColor1 = UIColor(actualRed: 8.0, green: 49.0, blue: 99.0, alpha: 1.0).cgColor
    private let gradientColor2 =  UIColor(actualRed: 4.0, green: 27.0, blue: 44.0, alpha: 1.0).cgColor
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadForAnimation()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.animatedTabBar(tabBar, didSelect: item)
    }
}

extension AmolTabBarControllerViewController: AnimatedTabBarControllerProtocol {
    
    public var barTintGradients: [CGColor] {
        return [gradientColor1, gradientColor2]
    }
    
    public var tabSelctionIndicatorColor: UIColor {
        return UIColor.white.withAlphaComponent(0.1)
    }
}

