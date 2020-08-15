//
//  HeadingWithDescriptionView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 10/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class HeadingWithDescriptionView: UIView {
    
    public lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10.0
        return stack
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public lazy var headingLabel: UILabel = { lable in
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.subSFHeading
        lable.textColor = Color.black1Colour
        lable.numberOfLines = 0
        return lable
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = { lable in
           lable.translatesAutoresizingMaskIntoConstraints = false
           lable.font = UIFont.sfBody
           lable.textColor = Color.black1Colour
           lable.numberOfLines = 0
           return lable
       }(UILabel())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .clear
        self.addSubview(self.stackView, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
        self.stackView.addArrangedSubview(self.headingLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        self.headingLabel.textAlignment = .center
        self.descriptionLabel.textAlignment = .center
        self.stackView.backgroundColor = .clear
    }
    
    public var title: String? {
        get {
          return self.headingLabel.text
        }
        set {
            self.headingLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    
    public var descriptionText: String? {
        get {
          return self.descriptionLabel.text
        }
        set {
            self.descriptionLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    
    public var headingTextColor: UIColor? {
        get {
          return self.headingLabel.textColor
        }
        set {
            self.headingLabel.textColor = newValue
        }
    }
    
    public var descripionTextColor: UIColor? {
        get {
          return self.descriptionLabel.textColor
        }
        set {
            self.descriptionLabel.textColor = newValue
        }
    }
}
