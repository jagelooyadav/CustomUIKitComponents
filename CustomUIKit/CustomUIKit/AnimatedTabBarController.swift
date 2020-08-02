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
        
        UIView.animate(withDuration: 0.3, animations: {
            guard let items = tabBar.items, let imageView = SelectionIndicator.imageView  else {
                return
            }
            let numberOfItems = CGFloat(items.count)
            imageView.center.x = self.tabBar.frame.width / numberOfItems / 2
            let number = -((items.index(of: item)?.distance(to: 0)) ?? 0) + 1
            let index = number - 1
            guard SelectionIndicator.previousIndex != index else { return }
            let singleItemCenter = tabBar.frame.width/numberOfItems/2
            let itemWidth = tabBar.frame.width/numberOfItems
            imageView.center.x = singleItemCenter + CGFloat(index) * itemWidth
            self.updateOfset(forIndex: index)
            /// update previous index after finsih operation
            SelectionIndicator.previousIndex = index
        })
    }
    
    public func viewDidLoadForAnimation() {
        SelectionIndicator.createIndicatorImage(inTabBar: self)
        guard let imageView = SelectionIndicator.imageView, let items = tabBar.items, !items.isEmpty else {
            return
        }
        self.tabBar.addSubview(imageView)
        let numberOfItems = CGFloat(items.count)
        imageView.center.x = self.tabBar.frame.width / numberOfItems / 2
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        self.tabBar.sendSubviewToBack(imageView)
        
        // Background Image
        let gradient = CAGradientLayer()
        gradient.frame = self.tabBar.bounds
        gradient.colors = self.barTintGradients
        let image = UIImage.gradientImageWithBounds(bounds: self.tabBar.bounds, colors: self.barTintGradients)
        self.tabBar.backgroundImage = image
        
        //Tint colors
        self.tabBar.tintColor = self.itemSelectedTintColor
        self.tabBar.unselectedItemTintColor = self.itemUnSelectedTintColor
        
        // font
        if let font = self.tabBarItemFont, let items = self.tabBar.items {
            for item in items {
                item.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
                item.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
            }
        }
        self.traverseTabs()
        SelectionIndicator.previousIndex = items.count - 1
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            UIView.animate(withDuration: 0.3, animations: {
                      self.updateOfset(forIndex: 0)
                      SelectionIndicator.previousIndex = 0
            }, completion: {_ in SelectionIndicator.previousIndex = 0 })
        }
    }
    
    private func updateOfset(forIndex index: Int) {
        let selectedButton = SelectionIndicator.iconButtons[index]
        guard let items = tabBar.items else {
            return
        }
        //Handle first time selection
        guard let imageView = SelectionIndicator.imageView else { return }
        
        if index > SelectionIndicator.previousIndex {
            var newIndex = SelectionIndicator.previousIndex
            
            while newIndex < index {
                let button = SelectionIndicator.iconButtons[newIndex]
                let numberOfItems = CGFloat(items.count)
                let singleItemCenter = tabBar.frame.width/numberOfItems/2
                let itemWidth = tabBar.frame.width/numberOfItems
                let centerX = singleItemCenter + CGFloat(newIndex) * itemWidth
                
                button.center.x = centerX - SelectionIndicator.adjustment
                newIndex += 1
            }
        }
        
        if index < SelectionIndicator.previousIndex {
            var newIndex = index
            while newIndex <= SelectionIndicator.previousIndex {
                let button = SelectionIndicator.iconButtons[newIndex]
                
                let numberOfItems = CGFloat(items.count)
                let singleItemCenter = tabBar.frame.width/numberOfItems/2
                let itemWidth = tabBar.frame.width/numberOfItems
                let centerX = singleItemCenter + CGFloat(newIndex) * itemWidth
                
                button.center.x = centerX + SelectionIndicator.adjustment
                newIndex += 1
            }
        }
        selectedButton.center.x = imageView.center.x
    }
    
    private func traverseTabs() {
        SelectionIndicator.titleLabels = []
        SelectionIndicator.iconButtons = []
        func findSubViews(parent: UIView) {
            guard !parent.subviews.isEmpty else {
                return
            }
            for subView in parent.subviews {
                if let label = subView as? UILabel {
                    SelectionIndicator.titleLabels.append(label)
                }
            
                if let button = subView as? UIControl {
                    SelectionIndicator.iconButtons.append(button)
                }
                findSubViews(parent: subView)
            }
        }
        findSubViews(parent: self.tabBar)
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
    
    static var titleLabels: [UILabel] = []
    static var iconButtons: [UIControl] = []
    static var previousIndex: Int = 0
    
    static let adjustment: CGFloat = 5.0
    
   static let animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut)
    }()
    
    static let buttonAnimator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    }()
    static func createIndicatorImage(inTabBar tabBarController: AnimatedTabBarControllerProtocol) {
        guard imageView == nil else { return }
        let color = tabBarController.tabSelctionIndicatorColor
        let scale = UIScreen.main.scale
        let image = UIImage.imageFrom(color: color, size: CGSize(width: tabBarController.tabIndicatorWidth / scale, height: tabBarController.tabBar.frame.height / scale ))
        imageView = UIImageView(image: image)
    }
}
