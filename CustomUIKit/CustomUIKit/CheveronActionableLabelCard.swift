//
//  CheveronActionableLabelCard.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 20/09/21.
//  Copyright © 2021 Jageloo. All rights reserved.
//

import UIKit

public class CheveronActionableLabelCard: UIView {
    
    public var title: String {
        get {
            return titleLabel.text ?? ""
        }
        
        set {
            titleLabel.text = newValue
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
    
    public var action: (() -> Void)?
    
    private lazy var titleLabel = UILabel()
    private lazy var cheveronImageView = UIImageView()
    
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
        container.anchorToSuperView(leading: 16.0, trailing: 16.0)
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(cheveronImageView)
        container.addSubview(contentStack)
        contentStack.anchorToSuperView(leading: 16.0, trailing: 16.0, top: 20.0, bottom: 21.0)
        contentStack.distribution = .fillProportionally
        contentStack.alignment = .center
        cheveronImageView.setContentCompressionResistancePriority(.required, for: .vertical)
        cheveronImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        cheveronImageView.setContentHuggingPriority(.required, for: .horizontal)
        cheveronImageView.setContentHuggingPriority(.required, for: .vertical)
        cheveronImageView.image = UIImage(systemName: "chevron.down")
        titleLabel.font = UIFont.sfRegularBody
        let button = UIButton()
        button.addTarget(self, action: #selector(self.didSelect), for: .touchUpInside)
    }
    
    @objc private func didSelect() {
        action?()
    }
}
