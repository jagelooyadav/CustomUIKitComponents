//
//  CheckMarkView.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 25/05/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class CheckMarkView: UIView {
    
    public enum CheckMarkState {
        case normal
        case tick
        case cross
    }
    
    // MARK: - Variables

    public var checkMarkSize: CGFloat = 60.0 {
        didSet {
            self.widthConstraint?.constant = self.checkMarkSize
            self.updateBorderColor(lineColor: nil)
        }
    }
    
    public var boderWidth: CGFloat = 1.0
    
    public var boderColor: UIColor?
    
    public var tickImage = UIImage.tickMarkImage
    
    public var untickImage = UIImage.untickMarkImage
        
    public var checkMarkState: CheckMarkState = .normal {
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
    
    private var widthConstraint: NSLayoutConstraint?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateBorderColor(lineColor: nil)
    }
    
    // MARK: - Functions
    
    private func setup() {
        let constraint = self.widthAnchor.constraint(equalToConstant: self.checkMarkSize)
        self.widthConstraint = constraint
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            constraint
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
            self.titleLabel.isHidden = false
        case .tick:
            self.imageView.image = self.tickImage
            borderColor = Color.greenColour
            self.titleLabel.isHidden = true
        case .cross:
            self.imageView.image = self.untickImage
            borderColor = Color.warningColour
            self.titleLabel.isHidden = true
        }
        self.updateBorderColor(lineColor: borderColor)
    }
    
    private func updateBorderColor(lineColor: UIColor?) {
        if let lineColor = lineColor {
            if let boderColor = self.boderColor {
                self.layer.borderColor = boderColor.cgColor
            } else {
                self.layer.borderColor = lineColor.cgColor
            }
        }
        self.layer.borderWidth = self.boderWidth
        self.layer.cornerRadius = self.bounds.width / 2.0
    }
}
