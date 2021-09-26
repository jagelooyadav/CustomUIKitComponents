//
//  IconButtonCard.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 21/09/21.
//  Copyright © 2021 Jageloo. All rights reserved.
//

import UIKit

public class IconButtonCard: ViewControl {
    
    public var title: String {
        get {
            return titleLabel.text ?? ""
        }
        
        set {
            let attributedString = NSAttributedString(string: newValue,
                                                      attributes: [NSAttributedString.Key.underlineStyle: 1])
            titleLabel.attributedText = attributedString
        }
    }
    
    public var cheveronImage: UIImage? {
        get {
            return cheveronImageView.image
        }
        set {
            cheveronImageView.image = newValue
        }
    }
    
    public var font: UIFont? {
        get {
            return titleLabel.font
        }
        set {
            titleLabel.font = newValue
        }
    }
    
    public var iconTintColor: UIColor? {
        get {
            return cheveronImageView.tintColor
        }
        
        set {
            cheveronImageView.tintColor = newValue
        }
    }
    
    public var action: ((String?) -> Void)?
    
    private lazy var titleLabel = UILabel()
    private lazy var cheveronImageView: UIImageView = { image in
        image.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        image.backgroundColor = .red
        return image
    }(UIImageView())
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let container = ContainerView()
        self.backgroundColor = .clear
        self.addSubview(container)
        container.anchorToSuperView(leading: 0, trailing: 0)
        container.backgroundColor = .clear
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.spacing = 20.0
        contentStack.addArrangedSubview(cheveronImageView)
        contentStack.addArrangedSubview(titleLabel)
        container.addSubview(contentStack)
        contentStack.anchorToSuperView(leading: 16.0, trailing: 16.0, top: 0, bottom: 0)
        contentStack.distribution = .fillProportionally
        contentStack.alignment = .center
        cheveronImageView.setContentCompressionResistancePriority(.required, for: .vertical)
        cheveronImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        cheveronImageView.setContentHuggingPriority(.required, for: .horizontal)
        cheveronImageView.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.font = UIFont.boldBody
        let button = UIButton()
        titleLabel.textColor = .blue
        button.addTarget(self, action: #selector(self.didSelect), for: .touchUpInside)
        self.addSubview(button)
        button.backgroundColor = .clear
        button.anchorToSuperView()
    }
    
    @objc private func didSelect() {
        action?(self.identifier)
    }
}
