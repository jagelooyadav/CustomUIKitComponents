//
//  EmptyRoundedBoxWithShadow.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 10/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class RoundTextInputView: ViewControl, ShadowProvider {
    public var containerView: UIView! {
        return self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public let textInputView = TextInputView()
    
    private func setup() {
        let containerView = UIView()
        self.backgroundColor = .clear
        containerView.layer.cornerRadius = 20.0
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.addSubview(self.textInputView, insets: UIEdgeInsets(top: 0.0, left: 0, bottom: 16.0, right: 0.0))
        self.addSubview( containerView, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0, right: 16.0))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.dropShadow()
    }
    
    public var title: String? {
        get {
            return nil
        }
        set {
            textInputView.title = newValue
        }
    }
    
    public var placeholder: String? {
        get {
            return nil
        }
        set {
            textInputView.placeholder = newValue
        }
    }
}

