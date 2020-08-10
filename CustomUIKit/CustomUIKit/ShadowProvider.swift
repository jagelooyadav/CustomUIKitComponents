//
//  ShadowProvider.swift
//  PhoneEstimator
//
//  Created by Jageloo Yadav on 08/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public protocol ShadowProvider {
    var containerView: UIView! { get }
    func dropShadow()
}

public extension ShadowProvider {
    func dropShadow() {
        self.containerView.layer.cornerRadius = 10
        
        // border
        self.containerView.layer.borderColor = UIColor.black.cgColor
        
        // shadow
        self.containerView.layer.shadowColor = UIColor.init(actualRed: 239.0, green: 110.0, blue: 92.0).cgColor
        self.containerView.layer.shadowOffset = CGSize(width: -5, height: 5)
        self.containerView.layer.shadowOpacity = 0.3
        self.containerView.layer.shadowRadius = 4.0
    }
}
