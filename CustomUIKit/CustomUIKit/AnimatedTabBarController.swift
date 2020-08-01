//
//  AnimatedTabBarController.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 01/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public protocol AnimatedTabBarControllerProtocol: UITabBarController {
    var tabSelctionIndicatorColor: UIColor { get }
    var tabIndicatorWidth: CGFloat { get }
    func viewDidLoadForAnimation()
    func animatedTabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    var barTintGradients: [CGColor] { get }
}

extension AnimatedTabBarControllerProtocol {
    
    public var tabIndicatorWidth: CGFloat { return 56.0 }
    
    public var barTintGradients: [CGColor] {
        return []
    }
    
    public func animatedTabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       UIView.animate(withDuration: 0.3) {
        guard let items = tabBar.items, let imageView = SelectionIndicator.imageView else {
            return
        }
           let numberOfItems = CGFloat(items.count)
           imageView.center.x = self.tabBar.frame.width / numberOfItems / 2
           let number = -(items.index(of: item)?.distance(to: 0))! + 1
           let index = number - 1
           let singleItemCenter = tabBar.frame.width/numberOfItems/2
           let itemWidth = tabBar.frame.width/numberOfItems
           imageView.center.x = singleItemCenter + CGFloat(index) * itemWidth
       }
   }
    
    public func viewDidLoadForAnimation() {
        SelectionIndicator.createIndicatorImage(inTabBar: self)
        guard let imageView = SelectionIndicator.imageView else {
            return
        }
        self.tabBar.addSubview(imageView)
        let numberOfItems = CGFloat(tabBar.items!.count)
        imageView.center.x = self.tabBar.frame.width / numberOfItems / 2
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        self.tabBar.sendSubviewToBack(imageView)
        let gradient = CAGradientLayer()
        gradient.frame = self.tabBar.bounds
        gradient.colors = self.barTintGradients
        let image = UIImage.gradientImageWithBounds(bounds: self.tabBar.bounds, colors: self.barTintGradients)
        self.tabBar.backgroundImage = image
    }
}

private extension UIImage {
    
    class func imageFrom(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage.init(cgImage: cgImage)
    }
    
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

private struct SelectionIndicator {
    static var imageView: UIImageView? = nil
    static func createIndicatorImage(inTabBar tabBarController: AnimatedTabBarControllerProtocol) {
        guard imageView == nil else { return }
        let color = tabBarController.tabSelctionIndicatorColor
        let scale = UIScreen.main.scale
        let image = UIImage.imageFrom(color: color.withAlphaComponent(0.26), size: CGSize(width: tabBarController.tabIndicatorWidth / scale, height: tabBarController.tabBar.frame.height / scale ))
        imageView = UIImageView(image: image)
    }
}
