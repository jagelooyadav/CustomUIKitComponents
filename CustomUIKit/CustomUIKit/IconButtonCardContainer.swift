//
//  IconButtonCardContainer.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 26/09/21.
//  Copyright © 2021 Jageloo. All rights reserved.
//

import UIKit

public class IconButtonCardContainer: UIView {
    
    public var title: String {
        get {
            return titleLabel.text ?? ""
        }
        
        set {
            titleLabel.text = newValue
        }
    }
    
    private lazy var titleLabel = UILabel()
    private lazy var cheveronImageView: UIImageView = { image in
        image.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        image.backgroundColor = .red
        return image
    }(UIImageView())
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16.0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let container = ContainerView()
        self.addSubview(container)
        container.anchorToSuperView(leading: 16.0, trailing: 16.0, top: 16.0)
        container.addSubview(titleLabel)
        titleLabel.anchorToSuperView(bottomRelation: .ignore,
                                     leading: 16.0,
                                     trailing: 16.0)
        container.addSubview(contentStack)
        contentStack.anchorToSuperView(topAnchor: titleLabel.bottomAnchor,
                                       top: 20,
                                       bottom: 20.0)
        titleLabel.font = UIFont.boldBody
    }
    
    public func addChild(subview: UIView) {
        self.contentStack.addArrangedSubview(subview)
    }
    
    public func clearChilds() {
        for view in self.contentStack.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}
