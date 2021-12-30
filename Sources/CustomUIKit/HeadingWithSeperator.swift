//
//  HeadingWithSeperator.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 11/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

public class HeadingWithSeperator: ViewControl {
    
    private let heading: String?
    
    public init(withString string: String? = nil) {
        self.heading = string
        super.init(frame: .zero)
        self.setup()
    }
    
    /// The title label.
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldHeading
        label.textColor = Appearance.color
        return label
    }()
    
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.heading = nil
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.addSubview(self.titleLabel, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), ignoreConstant: .bottom)
        let divider = DividerView()
        self.addSubview(divider, insets: UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16), ignoreConstant: .top)
        divider.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.titleLabel.text = self.heading
    }
}
