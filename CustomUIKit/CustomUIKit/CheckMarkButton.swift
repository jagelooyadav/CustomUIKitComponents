//
//  CheckMarkButton.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 24/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class CheckMarkButton: UIControl {
    
    public enum CheckMarkState {
        case normal
        case tick
        case cross
    }
    
    // MARK: - Variables
    
    public var checkMarkState: CheckMarkState {
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
    }
}

private class CheckMarkView: UIView {
    
    private let checkMarkSize: CGFloat = 60.0

    // MARK: - Variables

    var checkMarkState: CheckMarkButton.CheckMarkState = .normal {
        didSet {
            self.updateStyle()
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
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage.wifiImage
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.body
        title.numberOfLines = 0
        title.text = "TEST"
        return title
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateBorderColor(borderColor: nil)
    }
    
    // MARK: - Functions
    
    private func setup() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            self.widthAnchor.constraint(equalToConstant: self.checkMarkSize)
        ])
        
        self.addSubview(self.imageView, insets: .standardMargin)
        self.addSubview(self.titleLabel, insets: .zero)
        
        self.backgroundColor = .clear
    }
    
    private func updateStyle() {
        let borderColor: UIColor
        
        switch self.checkMarkState {
        case .normal:
            self.imageView.image = nil
            borderColor = Color.black1Colour
        case .tick:
            self.imageView.image = UIImage.tickMarkImage
            borderColor = Color.greenColour
        case .cross:
            self.imageView.image = UIImage.crossMarkImage
            borderColor = Color.warningColour
        }
        self.updateBorderColor(borderColor: borderColor)
    }
    
    private func updateBorderColor(borderColor: UIColor?) {
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.bounds.width / 2.0
    }
}
