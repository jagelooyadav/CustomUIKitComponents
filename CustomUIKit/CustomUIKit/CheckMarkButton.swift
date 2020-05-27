//
//  CheckMarkButton.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 24/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class CheckMarkButton: UIControl {
    
    public var identifier: Any?
    
    // MARK: - Variables
    public var checkMarkSize: CGFloat {
        get {
            return self.checkMarkView.checkMarkSize
        }
        
        set {
            self.checkMarkView.checkMarkSize = newValue
        }
    }
    
    public var boderWidth: CGFloat {
        get {
            return self.checkMarkView.boderWidth
        }
        
        set {
            self.checkMarkView.boderWidth = newValue
        }
    }
    
    public var boderColor: UIColor?{
        get {
            return self.checkMarkView.boderColor
        }
        
        set {
            self.checkMarkView.boderColor = newValue
        }
    }
    
    public var tickImage: UIImage? {
        get {
            return self.checkMarkView.tickImage
        }
        
        set {
            self.checkMarkView.tickImage = newValue
        }
    }
    
    public var untickImage: UIImage? {
        get {
            return self.checkMarkView.untickImage
        }
        
        set {
            self.checkMarkView.untickImage = newValue
        }
    }
    
    public var checkMarkState: CheckMarkView.CheckMarkState {
        get {
            return self.checkMarkView.checkMarkState
        }
        
        set {
            self.checkMarkView.checkMarkState = newValue
        }
    }
    
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
    public var defaultLabel: String? {
        get {
            return self.checkMarkView.title
        }
        
        set {
            self.checkMarkView.title = newValue
        }
    }
    
    public var defaultLabelFont: UIFont? {
        get {
            return self.checkMarkView.font
        }
        
        set {
            self.checkMarkView.font = newValue
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
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        return stackView
    }()
    
    private let checkMarkView = CheckMarkView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Functions
    
    private func setup() {
        self.stackView.addArrangedSubview(self.checkMarkView)
        self.stackView.addArrangedSubview(self.titleLabel)
        
        self.addSubview(self.stackView, insets: .zero)
        self.backgroundColor = .clear
        self.stackView.isUserInteractionEnabled = false
    }
}
