//
//  InputView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//
//

import UIKit

@objc public enum InputViewState: Int {
 
    case normal

    case valid
 
    case invalid
 
    case disabled
}

public class InputView: ViewControl {
 
    private static let topPadding: CGFloat = 10
  
    private static let bottomPadding: CGFloat = 0.0
    private static let horizontalPadding: CGFloat = 16.0
    
    private static let verticalSpacing: CGFloat = 10.0

    private static let valueViewHeight: CGFloat = 24.0
    
    private static let underlineHeight: CGFloat = 1.0
  
    private static let underlineBottomConstraintPriority = UILayoutPriority(999)
    
    private static let messageVerticalResistancePriority: UILayoutPriority = .required
    
    public typealias State = InputViewState

    @objc public var title: String? {
        get {
            return self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    public var titleLabelAccessibilityHint: String? {
        didSet {
            self.titleLabel.accessibilityHint = self.titleLabelAccessibilityHint
        }
    }
    @objc public var value: String? {
        get {
            return nil
        }
        
        set { }
    }
    @objc public var message: String? {
        get {
            return self._messageLabel?.text
        }
        
        set {
            (newValue != nil ? self.messageLabel : self._messageLabel)?.text = newValue
            self.update()
            self.updateAccessibilityText()
        }
    }
   
    public var prefixAccessibilityTextForErrorMessage: String?
    public var messageTextColor: UIColor? = Color.darkRed {
        didSet {
            
            self.messageLabel.textColor = self.messageTextColor ?? self.messageLabel.textColor
        }
    }
   
    @objc public var state: State = .normal {
        didSet {
            self.updateStyle()
        }
    }
   
    public var valueView: UIView? {
        return UIView()
    }
    
    @IBInspectable var titleLocalisationKey: String? {
        didSet {
            guard let key = self.titleLocalisationKey else { return }
            
            self.title = key
        }
    }
  
    @IBInspectable var messageLocalisationKey: String? {
        didSet {
            guard let key = self.messageLocalisationKey else { return }
            
            self.message = key
        }
    }
   
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSFRegualarSubHeading
        return label
    }()
  
    public var underlineView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: InputView.underlineHeight).isActive = true
        
        return view
    }()
   
    private var _messageLabel: UILabel?
   
    private var messageLabel: UILabel {
        get {
            if let label = self._messageLabel {
                return label
            } else {
                let label = UILabel()
                
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 0
                
                label.setContentCompressionResistancePriority(type(of: self).messageVerticalResistancePriority, for: .vertical)
                
                self.messageLabel = label
                
                return label
            }
        }
        
        set {
            self._messageLabel = newValue
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
  
    private func setup() {
        guard let valueView = self.valueView else { return }
      
        self.addSubview(self.titleLabel)
        self.addSubview(valueView)
        self.addSubview(self.underlineView)
        
        let selfType = type(of: self)
        let underlineBottomConstraint = self.bottomAnchor.constraint(equalTo: self.underlineView.bottomAnchor, constant: selfType.bottomPadding)
        underlineBottomConstraint.priority = selfType.underlineBottomConstraintPriority

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: selfType.topPadding),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
            self.trailingAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.trailingAnchor, constant: selfType.horizontalPadding),
            valueView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: selfType.verticalSpacing),

            valueView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
            self.trailingAnchor.constraint(equalTo: valueView.trailingAnchor, constant: selfType.horizontalPadding),
            self.underlineView.topAnchor.constraint(equalTo: valueView.bottomAnchor, constant: selfType.verticalSpacing),
            valueView.heightAnchor.constraint(equalToConstant: selfType.valueViewHeight),

            self.underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
            self.trailingAnchor.constraint(equalTo: self.underlineView.trailingAnchor, constant: selfType.horizontalPadding),
            underlineBottomConstraint
            ])
        
        self.update()
    }
  
    private func update() {
        if self.message != nil && self._messageLabel?.superview == nil {
            let label = self.messageLabel
      
            self.addSubview(label)
            let selfType = type(of: self)
       
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: self.underlineView.bottomAnchor, constant: selfType.verticalSpacing),
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
                self.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: selfType.horizontalPadding),
                self.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: selfType.bottomPadding)
                ])
            
            self.messageLabel.textColor = self.messageTextColor
            
        } else if self.message == nil && self._messageLabel?.superview != nil {
            self._messageLabel?.removeFromSuperview()
        }
        
        self.updateStyle()
    }

    private func updateAccessibilityText() {
        if let prefixAccessibilityTextForErrorMessage = self.prefixAccessibilityTextForErrorMessage,
            let message = self.message,
            self._messageLabel?.superview != nil {
            self.messageLabel.accessibilityLabel = prefixAccessibilityTextForErrorMessage + message
        }
    }
 
    func updateStyle() {
        switch self.state {
        case .invalid:
            self.titleLabel.textColor = Color.darkText
            self.underlineView.backgroundColor = Color.darkRed
            self.messageLabel.textColor = Color.darkRed
        case .disabled:
            self.underlineView.backgroundColor = Color.grey4
            self.messageLabel.textColor = Color.grey2
            self.titleLabel.textColor = Color.grey2
        case .normal,
             .valid:
            self.titleLabel.textColor = Color.darkText
            self.underlineView.backgroundColor = Color.grey3
            self.messageLabel.textColor = Color.lightText
        }
    }
}
