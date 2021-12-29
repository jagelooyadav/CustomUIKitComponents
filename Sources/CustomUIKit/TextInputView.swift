//
//  TextInputView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//
//

import UIKit

////
public class TextInputView: InputView {
    
    // MARK: Public
    
    /// The text field delegate.
    @objc public weak var delegate: TextInputViewDelegate? {
        didSet {
            self.textField.delegate = self.delegate != nil ? self : nil
        }
    }
    
    /// Color that is assigned to text field's text color - when input text is valid.
    public var textFieldTextColor: UIColor? {
        didSet {
            self.textField.textColor = self.textFieldTextColor ?? self.textField.textColor
        }
    }
    
    /// Color that is assigned to text field's text color - when input text is invalid.
    public var textFieldInvalidTextColor: UIColor? = Color.darkRedColour {
        didSet {
            self.textField.textColor = self.textFieldInvalidTextColor ?? self.textField.textColor
        }
    }
    
    /// Determines if the text field is enabled.
    public var isEnabled: Bool {
        get {
            return self.textField.isEnabled
        }
        
        set {
            self.textField.isEnabled = newValue
        }
    }
    
    /// The string that is displayed when there is no other text in the text input view.
    @objc public var placeholder: String? {
        get {
            return self.textField.placeholder
        }
        set {
            self.textField.placeholder = newValue
            
        }
    }
    
    /// The custom input view to display when the text input view becomes the first responder
    @objc public var textFieldInputView: UIView? {
        get {
            return self.textField.inputView
        }
        
        set {
            self.textField.inputView = newValue
        }
    }
    
    /// The custom accessory view to display when the text input view becomes the first responder
    @objc public var textFieldInputAccessoryView: UIView? {
        get {
            return self.textField.inputAccessoryView
        }
        
        set {
            self.textField.inputAccessoryView = newValue
        }
    }
    
    /// The keyboard style associated with the text input view.
    @objc public var keyboardType: UIKeyboardType {
        get {
            return self.textField.keyboardType
        }
        
        set {
            self.textField.keyboardType = newValue
        }
    }
    
    /// The autocorrection style for the text input view.
    @objc public var autocorrectionType: UITextAutocorrectionType {
        get {
            return self.textField.autocorrectionType
        }
        
        set {
            self.textField.autocorrectionType = newValue
        }
    }
    
    /// The supplementary image which is displayed by the text field.
    @objc public var supplementaryImage: UIImage? {
        get {
            return self.textField.supplementaryImage
        }
        
        set {
            self.textField.supplementaryImage = newValue
        }
    }

    public var customRightView: UIView? {
        didSet {
            // if right view already exists then remove
            oldValue?.removeFromSuperview()
            
            guard let newValue = self.customRightView else { return }
            
            // add the view over TextView to hide rightView of TextView
            self.addSubview(newValue)
            newValue.translatesAutoresizingMaskIntoConstraints = false
            
            // Constraints to add the custom right view on right side of text view.
            NSLayoutConstraint.activate([
                newValue.topAnchor.constraint(equalTo: self.textField.topAnchor, constant: 0.0),
                self.textField.bottomAnchor.constraint(equalTo: newValue.bottomAnchor, constant: 0.0),
                newValue.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor, constant: 0.0)
                ])
            
        }
    }
    
    /// Accessibility text for the textField.
    public var textFieldAccessibilityHintText: String? {
        get {
            return self.textField.accessibilityHint
        }
        
        set {
            self.textField.accessibilityTraits = UIAccessibilityTraits.staticText
            self.textField.accessibilityHint = newValue
        }
    }

    override public var value: String? {
        get {
            return self.textField.text
        }
        
        set {
            self.textField.text = newValue
        }
    }
    
    /// The text field displayed by the view. Do not access this externally.
    @objc override public var valueView: UIView? {
        return self.textField
    }
    
    override public func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
   
    @discardableResult override public func resignFirstResponder() -> Bool {
        return self.textField.resignFirstResponder()
    }
    
    /// Returns `true` if the text input view is the first responder, `false` otherwise.
    override public var isFirstResponder: Bool {
        return self.textField.isFirstResponder
    }
    
    // MARK: IBInspectable
    
    /// The localisation key to use for the placeholder for input view text field.
    @IBInspectable public var placeholderLocalisationKey: String? {
        didSet {
            guard let key = self.placeholderLocalisationKey else { return }
            
            self.placeholder = key
        }
    }
    
    /// Identifies whether the text object should disable text copying and in some cases hide the text being entered.
    @IBInspectable public var isSecureTextEntry: Bool {
        get {
            return self.textField.isSecureTextEntry
        }
        
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }
    
    // MARK: Private
    
    /// The text field.
     public var textField: TextField = {
        let textField = TextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rightViewMode = .always
        textField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        textField.font = UIFont.subSFHeading
        return textField
    }()
    
    @objc func insertTextAtCurrentPostion(text: String) {
        self.textField.insertText(text)
    }
    
    /// called when textfield text changed and tells the delegate about text change
    @objc private func textFieldTextDidChange() {
        
        self.delegate?.inputViewTextDidChange?(inInputView: self)
    }
    
    // MARK: UIView
    override func updateStyle() {
        super.updateStyle()
        
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
        
        switch self.state {
        case .normal:
            self.textField.icon = nil
            self.textField.textColor = Color.black1Colour
            
        case .valid:
            // customRightView is not required when icon is present
            self.customRightView = nil
            self.textField.icon = .tick
            self.textField.textColor = Color.black1Colour
            
        case .invalid:
            // customRightView is not required when icon is present
            self.customRightView = nil
            self.textField.icon = .exclamation
            self.textField.textColor = self.textFieldInvalidTextColor
            
        case .disabled:
            self.isEnabled = false
            self.textField.textColor = Color.grey2Colour
            self.textField.icon = nil
            self.textField.placeholder = self.placeholder
        }
        self.commonUpdateForNonDisabledState()
    }
    
    private func commonUpdateForNonDisabledState() {
        switch self.state {
        case .normal,
             .valid,
             .invalid:
            self.textField.placeholder = self.placeholder
            self.isEnabled = true
        case .disabled:
            break
        }
    }
}

extension TextInputView: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.delegate?.inputViewShouldBeginEditing?(inInputView: self) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.state == .normal, let rightTopView = self.customRightView {
            // hide the custom right view
            rightTopView.isHidden = true
        }
        
        self.delegate?.inputViewDidBeginEditing?(inInputView: self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if self.state == .normal, let rightTopView = self.customRightView {
            // show the custom right view
            rightTopView.isHidden = false
            // add padding equal to width of right view
            self.textField.textFieldRightPadding = rightTopView.bounds.width
        }
        return self.delegate?.inputViewShouldEndEditing?(inInputView: self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.inputViewDidEndEditing?(inInputView: self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.delegate?.inputView?(inInputView: self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return  self.delegate?.inputViewShouldReturn?(inInputView: self) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.delegate?.inputViewShouldClear?(inInputView: self) ?? true
    }
}

/// A delegate to observe changes within `TextInputView`.
@objc public protocol TextInputViewDelegate: AnyObject {
        @objc optional func inputViewShouldBeginEditing(inInputView inputView: TextInputView) -> Bool
    
    @objc optional func inputViewDidBeginEditing(inInputView inputView: TextInputView)
    
    @objc optional func inputViewShouldEndEditing(inInputView inputView: TextInputView) -> Bool
    
    @objc optional func inputViewDidEndEditing(inInputView inputView: TextInputView)
    
    @objc optional func inputView(inInputView inputView: TextInputView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
  
    @objc optional func inputViewShouldReturn(inInputView inputView: TextInputView) -> Bool
    
    @objc optional func inputViewTextDidChange(inInputView inputView: TextInputView)
    
    @objc optional func inputViewShouldClear(inInputView inputView: TextInputView) -> Bool
}
