//
//  InputView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//
//

import UIKit

// MARK: - Enums

/// A state which an input view can be in.
@objc public enum InputViewState: Int {
    /// The component has neither a valid or invalid value.
    case normal
    
    /// The component has a valid value.
    case valid
    
    /// The component has an invalid value.
    case invalid
    
    /// The component has a disabled value.
    case disabled
}

public class InputView: ViewControl {
    
    // MARK: - Constants
    
    /// The amount of padding beeen the top of the view and it's content.
    private static let topPadding: CGFloat = 10
    
    /// The amount of padding beeen bottom of the view and it's content.
    private static let bottomPadding: CGFloat = 0.0
    
    /// The amount of padding beeen the left and right of the view and it's content.
    private static let horizontalPadding: CGFloat = 16.0
    
    /// The amount of vertical spacing beeen subviews views.
    private static let verticalSpacing: CGFloat = 10.0
    
    /// The height of the value view.
    private static let valueViewHeight: CGFloat = 24.0
    
    /// The height of the underline.
    private static let underlineHeight: CGFloat = 1.0
    
    /// The priority of the bottom underline constraint.
    private static let underlineBottomConstraintPriority = UILayoutPriority(999)
    
    /// The vertical compression resistance priority of the message label.
    private static let messageVerticalResistancePriority: UILayoutPriority = .required
    
    public typealias State = InputViewState

    // MARK: - Variables
    
    // MARK: Main
    
    /// The title of the input.
    @objc public var title: String? {
        get {
            return self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
    /**
     Optional text for accessibility hint of title label.
     */
    public var titleLabelAccessibilityHint: String? {
        didSet {
            self.titleLabel.accessibilityHint = self.titleLabelAccessibilityHint
        }
    }
    
    /**
     The value of the view.
     
     This needs to be overriden by the subclass.
     */
    @objc public var value: String? {
        get {
            return nil
        }
        
        set { }
    }
    
    /**
     The optional message displayed below the input area.
     */
    @objc public var message: String? {
        get {
            return self._messageLabel?.text
        }
        
        set {
            (newValue != nil ? self.messageLabel : self._messageLabel)?.text = newValue
            
            // Update the layout if needed.
            self.update()
            // Update accessibility text for error message
            self.updateAccessibilityText()
        }
    }
    
    /**
     Optional text that gets append before input view
     error message in accessibility.
     */
    public var prefixAccessibilityTextForErrorMessage: String?
    
    /**
     Color for the optional message displayed below the input area.
     */
    public var messageTextColor: UIColor? = Color.darkRedColour {
        didSet {
            
            self.messageLabel.textColor = self.messageTextColor ?? self.messageLabel.textColor
        }
    }
    
    /**
     The state which the view is in.
     
     Defaults to `normal`.
     */
    @objc public var state: State = .normal {
        didSet {
            self.updateStyle()
        }
    }
    
    /**
     The view which accepts input and displays a value.
     
     This needs to be overriden by the subclass.
     */
    public var valueView: UIView? {
        return UIView()
    }
    
    // MARK: IBInspectable
    
    /// The localisation key to use for the title displayed by the input view. Sets the `title` value.
    @IBInspectable var titleLocalisationKey: String? {
        didSet {
            guard let key = self.titleLocalisationKey else { return }
            
            self.title = key
        }
    }
    
    /// The localisation key to use for the message displayed by the input view. Sets the `message` value.
    @IBInspectable var messageLocalisationKey: String? {
        didSet {
            guard let key = self.messageLocalisationKey else { return }
            
            self.message = key
        }
    }
    
    // MARK: Private
    
    /// The title label.
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.subSFHeading
        return label
    }()
    
    /// The view used to display an 'underline' beneath the value view.
    public var underlineView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: InputView.underlineHeight).isActive = true
        
        return view
    }()
    
    /**
     The message label.
     
     If you need a guaranteed non-nil (lazy loaded) reference, use `messageLabel` instead.
     */
    private var _messageLabel: UILabel?
    
    /**
     The message label.
     
     Creates a new instance if one does not already exist.
     
     If you do not need a guaranteed non-nil reference, use `_messageLabel` instead.
     */
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
    
    // MARK: - Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    // MARK: - Functions
    
    /// Performs setup of the view.
    private func setup() {
        // Guard against an invalid value view.
        guard let valueView = self.valueView else { return }
        
        // Add all core subviews.
        self.addSubview(self.titleLabel)
        self.addSubview(valueView)
        self.addSubview(self.underlineView)
        
        let selfType = type(of: self)
        
        // Create the underline bottom constraint with a lower priority so that the message label will layout correctly.
        let underlineBottomConstraint = self.bottomAnchor.constraint(equalTo: self.underlineView.bottomAnchor, constant: selfType.bottomPadding)
        underlineBottomConstraint.priority = selfType.underlineBottomConstraintPriority
        
        // Add core constraints.
        NSLayoutConstraint.activate([
            // Title Label
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: selfType.topPadding),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
            self.trailingAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.trailingAnchor, constant: selfType.horizontalPadding),
            valueView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: selfType.verticalSpacing),
            
            // Value View
            valueView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
            self.trailingAnchor.constraint(equalTo: valueView.trailingAnchor, constant: selfType.horizontalPadding),
            self.underlineView.topAnchor.constraint(equalTo: valueView.bottomAnchor, constant: selfType.verticalSpacing),
            valueView.heightAnchor.constraint(equalToConstant: selfType.valueViewHeight),
            
            // Underline View
            self.underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
            self.trailingAnchor.constraint(equalTo: self.underlineView.trailingAnchor, constant: selfType.horizontalPadding),
            underlineBottomConstraint
            ])
        
        self.update()
    }
    
    /// Updates the layout of the view and it's style.
    private func update() {
        if self.message != nil && self._messageLabel?.superview == nil {
            // Add the message label as it is missing.
            let label = self.messageLabel
            
            // Add the subview.
            self.addSubview(label)
            
            let selfType = type(of: self)
            
            // Add constraints.
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: self.underlineView.bottomAnchor, constant: selfType.verticalSpacing),
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: selfType.horizontalPadding),
                self.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: selfType.horizontalPadding),
                self.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: selfType.bottomPadding)
                ])
            
            self.messageLabel.textColor = self.messageTextColor
            
        } else if self.message == nil && self._messageLabel?.superview != nil {
            // Remove the message label.
            self._messageLabel?.removeFromSuperview()
        }
        
        self.updateStyle()
    }
    
    /// Append 'error' before error message as per accessibility requirement for Input view
    private func updateAccessibilityText() {
        if let prefixAccessibilityTextForErrorMessage = self.prefixAccessibilityTextForErrorMessage,
            let message = self.message,
            self._messageLabel?.superview != nil {
            self.messageLabel.accessibilityLabel = prefixAccessibilityTextForErrorMessage + message
        }
    }
    
    /// Updates the style of the view, based upon the current state.
    
    func updateStyle() {
        switch self.state {
        case .invalid:
            self.titleLabel.textColor = Color.darkTextColour
            self.underlineView.backgroundColor = Color.darkRedColour
            self.messageLabel.textColor = Color.darkRedColour
        case .disabled:
            self.underlineView.backgroundColor = Color.grey4Colour
            self.messageLabel.textColor = Color.grey2Colour
            self.titleLabel.textColor = Color.grey2Colour
        case .normal,
             .valid:
            self.titleLabel.textColor = Color.darkTextColour
            self.underlineView.backgroundColor = Color.grey3Colour
            self.messageLabel.textColor = Color.lightTextColour
        }
    }
}
