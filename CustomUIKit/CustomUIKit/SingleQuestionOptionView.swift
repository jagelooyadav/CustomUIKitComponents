//
//  SingleQuestionOptionView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 06/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

class SingleQuestionOptionView: ViewControl {
    
    private var option: String!
    private var index = 0
    
    lazy var containerView: ContainerView = { container in
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 5.0
        return container
    }(ContainerView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private  lazy var titleLabel: UILabel = { lable in
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.body
        lable.textColor = Color.black1Colour
        return lable
    }(UILabel())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    init(option: String, at index: Int) {
        self.option = option
        super.init(frame: .zero)
        self.setup()
    }
    
    var didSelect: ((_ title: String?, _ index: Int) -> Void)?
    var borderColor: UIColor? {
        get {
            guard let color = self.containerView.layer.borderColor else { return nil }
            return  UIColor(cgColor: color)
        }
        set {
            self.containerView.layer.borderColor = newValue?.cgColor
        }
    }
    
    var isSelected: Bool = false  {
        didSet {
            self.borderColor = self.isSelected ? Color.appColour : Color.appColour.withAlphaComponent(0.5)
            self.containerView.layer.borderWidth = self.isSelected ? 2.0 : 1.0
            self.containerView.backgroundColor = Color.appColour.withAlphaComponent(self.isSelected ? 0.3 : 0.01)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 16.0
        return stack
    }()
    
    var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    private lazy var touchButton = UIButton()
    
    private func setup() {
        self.addSubview(self.containerView, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0.0, right: 16.0))
        self.containerView.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        self.isSelected = false
        self.containerView.addSubview(self.stackView, insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        let sequenceView = UIView()
        sequenceView.translatesAutoresizingMaskIntoConstraints = false
        sequenceView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sequenceView.layer.borderColor = Color.appColour.cgColor
        sequenceView.layer.borderWidth = 0.5
        sequenceView.layer.cornerRadius = 5.0
        let label = UILabel()
        label.font = UIFont.body
        label.textAlignment = .center
        label.text = String.init(format: "%C", 65 + index)
        label.font = UIFont.body
        label.textColor = Color.appColour
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        sequenceView.addSubview(label, insets: .zero)
        self.stackView.addArrangedSubview(sequenceView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.text = self.option
        
        self.containerView.addSubview(self.touchButton, insets: .zero)
        self.touchButton.addTarget(self, action: #selector(self.click), for: .touchUpInside)
        
    }
    @objc private func click() {
        print("print...")
        self.didSelect?(self.titleLabel.text, self.index)
    }
}
