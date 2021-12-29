//
//  ProductPriceCard.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 26/09/21.
//  Copyright © 2021 Jageloo. All rights reserved.
//

import Foundation
import UIKit

public class ProductPriceCard: UIView {
    
    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()
    
    public var priceString: String {
        get {
            return titleLabel.text ?? ""
        }
        
        set {
            titleLabel.text = newValue
        }
    }
    
    public var descriptionString: String {
        get {
            return subTitleLabel.text ?? ""
        }
        
        set {
            subTitleLabel.text = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let container = ContainerView()
    func setup() {
        
        self.addSubview(container)
        container.anchorToSuperView(leadingRelation: .greaterOrEqual,
                                     trailingRelation: .greaterOrEqual,
                                     topRelation: .greaterOrEqual,
                                     bottomRelation: .greaterOrEqual,
                                     leading: 20,
                                     trailing: 20,
                                     top: 0,
                                     bottom: 0)
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.font = UIFont.priceBigHeading
        subTitleLabel.font = UIFont.boldSubHeading
        titleLabel.textColor = .white
        subTitleLabel.textColor = .white
        container.addSubview(titleLabel)
        titleLabel.anchorToSuperView(bottomRelation: .ignore,
                                     leading: 30.0,
                                     trailing: 30.0,
                                     top: 30)
        container.addSubview(subTitleLabel)
        subTitleLabel.anchorToSuperView(topAnchor: titleLabel.bottomAnchor, leading: 30, trailing: 30, top: 5, bottom: 30.0)
        titleLabel.textAlignment = .center
        subTitleLabel.textAlignment = .center
    }
    
    private let gradient = CAGradientLayer()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradient.removeFromSuperlayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.orange.cgColor,UIColor.init(actualRed: 237.0, green: 63.0, blue: 110.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.0, 0.5]
        container.layer.insertSublayer(gradient, at: 0)
    }
}
