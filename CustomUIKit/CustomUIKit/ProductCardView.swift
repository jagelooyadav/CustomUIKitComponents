//
//  ProductCardView.swift
//  CustomUIKit
//
//  Created by Chirag on 12/09/21.
//  Copyright © 2021. All rights reserved.
//

import UIKit

public class ProductCardView: ViewControl {
    
    public var productInfo: String? {
        get {
            return self.productinfoLabel.text
        }
        set{
            self.productinfoLabel.text = newValue
        }
    }
    
    public var productImage: UIImage? {
        get{
            return self.productImageView.image
        }
        set {
            self.productImageView.image = newValue
        }
    }
    
    public var productTitle: String? {
        get{
            return self.producttitleLabel.text
        }
        set {
            self.producttitleLabel.text = newValue
        }
    }
    
    public var productsubTitle: String? {
        get{
            return self.productsubtitleLabel.text
        }
        set {
            self.productsubtitleLabel.text = newValue
        }
    }
    
    public var productPrice: String? {
        get {
            return self.productpriceLabel.text
        }
        set {
            self.productpriceLabel.text = newValue
        }
    }
    
    // The info label.
    private var productinfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldBody
        return label
    }()
    
    private var productImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var producttitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldHeading
        
        return label
    }()
    
    private var productsubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSFRegualarSubHeading
        label.textColor = Color.grey1Colour
        return label
    }()
    
    private var productpriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSFRegualarSubHeading
        label.textColor = Color.darkGrey1Colour
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .clear
        let container = ContainerView()
        self.addSubview(container)
        container.anchorToSuperView(leading: 16.0, trailing: 16.0)
        
        let titleContainer = UIView()
        titleContainer.addSubview(productinfoLabel)
        productinfoLabel.anchorToSuperView(trailingRelation: .greaterOrEqual, leading: 16, trailing: 16, top: 16, bottom: 16)
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.distribution = .fill
        stack.alignment = .center
        container.addSubview(stack)
        stack.anchorToSuperView(leading: 16, trailing: 16, top: 16, bottom: 16)
    
        let  devider = DividerView()
        devider.backgroundColor = Color.grey3Colour
        devider.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleContainer)
        stack.addArrangedSubview(productImageView)
        stack.addArrangedSubview(producttitleLabel)
        stack.addArrangedSubview(productsubtitleLabel)
        stack.addArrangedSubview(devider)
        
        devider.widthAnchor.constraint(equalTo: productsubtitleLabel.widthAnchor, constant: 120).isActive = true
        stack.addArrangedSubview(productpriceLabel)
        stack.setCustomSpacing(10, after: productsubtitleLabel)
        stack.setCustomSpacing(10, after: devider)
        
        titleContainer.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: 20).isActive = true
        
    }
}

