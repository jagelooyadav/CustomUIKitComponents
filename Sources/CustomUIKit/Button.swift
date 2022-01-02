//
//  Button.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//

import UIKit
 
public class Button: UIButton {
    public enum ButtonType {
        case bordered
        case plane
    }
    
    public var customType: ButtonType = .plane {
        didSet {
            updateLayout()
        }
    }
    
    
    public var primaryColor = UIColor.init(actualRed: 237.0, green: 63.0, blue: 110.0) {
        didSet {
            updateLayout()
        }
    }
    
    func updateLayout() {
        switch customType {
            case .bordered:
                self.layer.borderColor = primaryColor.cgColor
                self.backgroundColor = .white
                self.setTitleColor(primaryColor, for: .normal)
            case .plane:
                self.layer.borderColor = UIColor.clear.cgColor
                self.backgroundColor = primaryColor
                self.setTitleColor(.white, for: .normal)
        }
    }
    
    public let gradient = CAGradientLayer()
    public var primaryGradientColors: [CGColor] = [] {
        didSet {
            self.setBackgroundImage(UIImage.gradientButton, for: .normal)
            self.layer.cornerRadius = 24.0
            self.clipsToBounds = true
            self.backgroundColor = .clear
            self.layer.borderColor = UIColor.clear.cgColor
            self.setTitleColor(.white, for: .normal)
        }
    }

    private var heightConstraint: NSLayoutConstraint?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    override public var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                self.alpha = 0.6
                self.titleLabel?.alpha = 0.6
            } else {
                self.alpha = 1.0
                self.titleLabel?.alpha = 1.0
            }
        }
    }
    
    public var height: CGFloat = 50.0 {
        didSet {
            self.heightConstraint?.constant = height
        }
    }

    
    // MARK: - Private Functions
    
    /// Performs an initial setup of the button.
    private func setup() {
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        self.heightConstraint?.isActive = true
        self.titleLabel?.font = UIFont.boldBody
        self.contentEdgeInsets = UIEdgeInsets.init(top: self.contentEdgeInsets.top, left: 10.0, bottom: self.contentEdgeInsets.bottom, right: 10.0)
        updateLayout()
    }
    
    private lazy var scaledFont: UIFont? = {
        guard let font = self.titleLabel?.font else { return nil }
        return UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
    }()
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.preferredContentSizeCategory > .accessibilityMedium {
            self.titleLabel?.adjustsFontSizeToFitWidth = true
            self.titleLabel?.font = self.scaledFont
        } else {
            self.heightConstraint?.isActive = true
            self.titleLabel?.adjustsFontSizeToFitWidth = false
            self.titleLabel?.font = UIFont.boldBody
        }
        self.layoutIfNeeded()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
