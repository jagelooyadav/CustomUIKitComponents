//
//  RoundedInformationBox.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 03/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import Foundation
import UIKit

class RoundedInformationBox: ViewControl {
    
    var title: String? {
        get {
            return self.titleLabel.title
        }
        set {
            self.titleLabel.title = newValue
            self.layoutIfNeeded()
        }
    }
    
    var value: String? {
        get {
            return self.valueLabel.text
        }
        set {
            self.valueLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    
    lazy var containerView: ContainerView = { container in
        //container.backgroundColor = Color.appColour.withAlphaComponent(0.01)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }(ContainerView())
    
    private lazy var titleLabel: HeadingWithSeperator = {
         HeadingWithSeperator()
    }()
    
    private lazy var valueLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.containerView.addSubview(self.verticalStack, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        self.verticalStack.addArrangedSubview(self.titleLabel)
        self.verticalStack.addArrangedSubview(self.valueLabel)
        self.valueLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.valueLabel.leadingAnchor.constraint(equalTo: self.verticalStack.leadingAnchor, constant: 16.0).isActive = true
        self.addSubview(self.containerView, insets: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        self.valueLabel.textColor = Color.black1Colour
    }
}
