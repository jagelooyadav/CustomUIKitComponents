//
//  NavigationViewController.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 02/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
class NavigationViewController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let color = Appearance.color
        //let image = UIImage.init(color: color, size: self.navigationBar.bounds.size)
        //self.navigationBar.setBackgroundImage(image, for: .default)
        //self.navigationBar.barStyle = .blackTranslucent
        let navigationBar = navigationController?.navigationBar
        if #available(iOS 13.0, *) {
            //let navigationBarAppearence = UINavigationBarAppearance()
            //navigationBarAppearence.shadowColor = .clear
            //navigationBar?.scrollEdgeAppearance = navigationBarAppearence
        } else {
            // Fallback on earlier versions
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.backBarButtonItem?.setBackgroundImage(UIImage.init(named: "back"), for: .normal, barMetrics: .default)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    }
}
