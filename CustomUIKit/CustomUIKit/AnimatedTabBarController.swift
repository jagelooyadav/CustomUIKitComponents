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
    var itemSelectedTintColor: UIColor { get }
    var itemUnSelectedTintColor: UIColor { get }
    var tabBarItemFont: UIFont? { get }
}

extension AnimatedTabBarControllerProtocol {
    
    public var tabIndicatorWidth: CGFloat { return 56.0 }
    
    public var barTintGradients: [CGColor] {
        return []
    }
    
    public var itemSelectedTintColor: UIColor {
        return UIColor(actualRed: 122.0, green: 193.0, blue: 75.0, alpha: 1.0)
    }
    
    public var itemUnSelectedTintColor: UIColor {
        return .white
    }
    
    public var tabBarItemFont: UIFont? {
        return nil
    }
    
    public func animatedTabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        SelectionIndicator.animator.addAnimations {
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
        SelectionIndicator.animator.startAnimation()
    }
    
    public func viewDidLoadForAnimation() {
        SelectionIndicator.createIndicatorImage(inTabBar: self)
        guard let imageView = SelectionIndicator.imageView, let items = tabBar.items else {
            return
        }
        self.tabBar.addSubview(imageView)
        let numberOfItems = CGFloat(items.count)
        imageView.center.x = self.tabBar.frame.width / numberOfItems / 2
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        self.tabBar.sendSubviewToBack(imageView)
        let gradient = CAGradientLayer()
        gradient.frame = self.tabBar.bounds
        gradient.colors = self.barTintGradients
        let image = UIImage.gradientImageWithBounds(bounds: self.tabBar.bounds, colors: self.barTintGradients)
        self.tabBar.backgroundImage = image
        self.tabBar.tintColor = self.itemSelectedTintColor
        self.tabBar.unselectedItemTintColor = self.itemUnSelectedTintColor
        
        // font
        if let font = self.tabBarItemFont, let items = self.tabBar.items {
            for item in items {
                item.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
                item.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
            }
        }
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
        if let context = UIGraphicsGetCurrentContext() {
           gradientLayer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

private struct SelectionIndicator {
    static var imageView: UIImageView? = nil
    
   static let animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut)
    }()
    static func createIndicatorImage(inTabBar tabBarController: AnimatedTabBarControllerProtocol) {
        guard imageView == nil else { return }
        let color = tabBarController.tabSelctionIndicatorColor
        let scale = UIScreen.main.scale
        let image = UIImage.imageFrom(color: color, size: CGSize(width: tabBarController.tabIndicatorWidth / scale, height: tabBarController.tabBar.frame.height / scale ))
        imageView = UIImageView(image: image)
    }
}
