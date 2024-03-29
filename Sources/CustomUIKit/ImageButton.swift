//
//  ImageButton.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 02/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import Foundation
import UIKit

public class ImageButton: ViewControl {
    private lazy var touchButton = UIButton()
    public var didSelect: ((ImageButton) -> Void)?
    public var borderColor: UIColor? {
        get {
            guard let color = self.containerView.layer.borderColor else { return nil }
            return  UIColor(cgColor: color)
        }
        set {
            self.containerView.layer.borderColor = newValue?.cgColor
        }
    }
    
    public var isSelected: Bool = false  {
        didSet {
            self.borderColor = self.isSelected ? Appearance.color : Appearance.color.withAlphaComponent(0.5)
            self.containerView.layer.borderWidth = self.isSelected ? 2.0 : 1.0
            self.containerView.backgroundColor = Appearance.color.withAlphaComponent(self.isSelected ? 0.3 : 0.01)
        }
    }
    
    public lazy var containerView: ContainerView = { container in
        container.backgroundColor = Appearance.color.withAlphaComponent(0.01)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }(ContainerView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.containerView.addSubview(self.imageView, insets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
        self.stackView.addArrangedSubview( self.containerView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.isSelected = false
        self.touchButton.addTarget(self, action: #selector(self.click), for: .touchUpInside)
        self.addSubview(self.stackView, insets: .zero)
        self.addSubview(self.touchButton, insets: .zero)
        self.imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc private func click() {
        print("print...")
        self.didSelect?(self)
    }
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.body
        return title
    }()
    
    public var buttonImage: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            
            self.imageView.image = newValue
            self.imageView.contentMode = .scaleAspectFit
            self.layoutIfNeeded()
        }
    }
    
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    
    public var fixHeighidth: CGFloat = 0 {
        didSet {
            self.heightAnchor.constraint(equalToConstant: self.fixHeighidth).isActive = true
            self.widthAnchor.constraint(equalToConstant: self.fixHeighidth).isActive = true
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = self.bounds.size.width / 2
    }
}
