//
//  UIViewController+Alert.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 30/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func present(alertWithTitle title: String, message: String, options: String..., completion: ((Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion?(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
