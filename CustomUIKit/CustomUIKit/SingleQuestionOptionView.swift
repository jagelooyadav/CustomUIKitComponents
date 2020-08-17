//
//  SingleQuestionOptionView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 06/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

public class SingleQuestionOptionView: ViewControl {
    
    private var option: String!
    private var index = 0
    
    public lazy var containerView: ContainerView = { container in
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
        lable.font = UIFont.sfRegularBody
        lable.textColor = .black
        return lable
    }(UILabel())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public init(option: String, at index: Int) {
        self.option = option
        self.index = index
        super.init(frame: .zero)
        self.setup()
    }
    
    public var didSelect: ((_ title: String?, _ index: Int) -> Void)?
    
    public var didSelectM: ((_ title: String?, _ index: Int, _ selectionStatus: Bool) -> Void)?
    
    public var borderColor: UIColor? {
        get {
            guard let color = self.containerView.layer.borderColor else { return nil }
            return  UIColor(cgColor: color)
        }
        set {
            self.containerView.layer.borderColor = newValue?.cgColor
        }
    }
    let color = UIColor.init(actualRed: 237.0, green: 63.0, blue: 110.0)
    public let gradient = CAGradientLayer()
    public var isSelected: Bool = false  {
        didSet {
            //button.primaryColor = UIColor.init(actualRed: 237.0, green: 63.0, blue: 110.0)
            self.borderColor = self.isSelected ? color : color.withAlphaComponent(0.5)
            self.containerView.layer.borderWidth = self.isSelected ? 0.0 : 2.0
            
            gradient.frame = self.bounds
            gradient.colors = [UIColor.init(actualRed: 239.0, green: 110.0, blue: 92.0).cgColor,UIColor.init(actualRed: 237.0, green: 63.0, blue: 110.0).cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.50)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.50)
            if self.isSelected {
                containerView.layer.insertSublayer(gradient, at: 0)
            } else {
                gradient.removeFromSuperlayer()
            }
            
            self.titleLabel.textColor = self.isSelected ? .white : Color.black1Colour
            self.sequenceView.layer.borderColor = self.isSelected ? UIColor.white.cgColor : color.cgColor
            self.label.textColor = self.isSelected ? UIColor.white : color
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
    
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    private lazy var touchButton = UIButton()
    
    private let sequenceView = UIView()
    private let label = UILabel()
    
    private func setup() {
        self.addSubview(self.containerView, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0.0, right: 16.0))
        self.containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48.0).isActive = true
        self.isSelected = false
        self.containerView.addSubview(self.stackView, insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        sequenceView.translatesAutoresizingMaskIntoConstraints = false
        sequenceView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sequenceView.layer.borderColor = color.cgColor
        sequenceView.layer.borderWidth = 0.5
        sequenceView.layer.cornerRadius = 5.0

        label.font = UIFont.sfBody
        label.textAlignment = .center
        label.text = String.init(format: "%C", 65 + index)
        label.numberOfLines = 0
        label.font = UIFont.sfBody
        label.textColor = color
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        sequenceView.addSubview(label, insets: .zero)
        //self.stackView.addArrangedSubview(sequenceView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.text = self.option
        
        self.containerView.addSubview(self.touchButton, insets: .zero)
        self.touchButton.addTarget(self, action: #selector(self.click), for: .touchUpInside)
        
    }
    @objc private func click() {
        print("print...")
        self.didSelect?(self.titleLabel.text, self.index)
        self.didSelectM?(self.titleLabel.text, self.index, self.isSelected)
    }
}
