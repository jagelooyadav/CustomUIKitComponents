//
//  ImageInputTextView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 09/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

class ImageInputTextView: ViewControl {
    
    var widthConstraint: NSLayoutConstraint?
    
    var borderColor: UIColor? {
        get {
            guard let color = self.containerView.layer.borderColor else { return nil }
            return  UIColor(cgColor: color)
        }
        set {
            self.containerView.layer.borderColor = newValue?.cgColor
        }
    }
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.body
        title.numberOfLines = 0
        return title
    }()
    
    var isSelected: Bool = false  {
        didSet {
            self.borderColor = self.isSelected ? Color.appColour : UIColor.clear
            self.containerView.layer.borderWidth = self.isSelected ? 2.0 : 0.0
            self.containerView.backgroundColor = Color.appColour.withAlphaComponent(self.isSelected ? 0.3 : 0.01)
        }
    }
    
    lazy var containerView: ContainerView = { container in
        container.backgroundColor = Color.appColour.withAlphaComponent(0.01)
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
        self.stackView.addArrangedSubview( self.titleLabel)
        self.stackView.addArrangedSubview( self.containerView)
        self.stackView.addArrangedSubview(self.inputTextField)
        self.isSelected = false
        self.addSubview(self.stackView, insets: .zero)
        self.imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
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
    
    private lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }()
    
    lazy var inputTextField: TextInputView = {
        let title = TextInputView()
        title.translatesAutoresizingMaskIntoConstraints = false
        self.widthConstraint = title.widthAnchor.constraint(equalToConstant: 120.0)
        self.widthConstraint?.isActive = true
        title.underlineView.backgroundColor = Color.appColour
        return title
    }()
    
    var icon: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            
            self.imageView.image = newValue
            self.imageView.contentMode = .scaleAspectFit
            self.layoutIfNeeded()
        }
    }
    
    var isAxisVetical: Bool = true {
        didSet {
            guard self.isAxisVetical == false else { return }
            //self.stackView.axis = .horizontal
            self.stackView.removeArrangedSubview(self.containerView)
            self.stackView.removeArrangedSubview(self.inputTextField)
            self.stackView.removeArrangedSubview(self.titleLabel)
            self.horizontalStackView.addArrangedSubview(self.inputTextField)
            self.stackView.addArrangedSubview(self.titleLabel)
            self.horizontalStackView.addArrangedSubview(self.containerView)
            self.stackView.addArrangedSubview(self.horizontalStackView)
            self.widthConstraint?.constant = 200.0
            self.layoutIfNeeded()
        }
    }
    
    var text: String? {
        get {
            return self.inputTextField.value
        }
        set {
            self.inputTextField.value = newValue
            self.layoutIfNeeded()
        }
    }
    
    var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    
    var fixHeighidth: CGFloat = 0 {
        didSet {
            self.heightAnchor.constraint(equalToConstant: self.fixHeighidth).isActive = true
            self.widthAnchor.constraint(equalToConstant: self.fixHeighidth).isActive = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isAxisVetical {
            self.containerView.layer.cornerRadius = self.bounds.size.width / 2
        }
    }
}
