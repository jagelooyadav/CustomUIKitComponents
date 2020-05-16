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

    // MARK: Overrides
    
    /// The value within the text field.
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
    
    /**
     Notifies the receiver that it is about to become first responder in its window.
     
     - returns: `true` if the receiver accepts first-responder status or `false` if it refuses this status.
     */
    override public func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    /**
     Notifies the text field that it has been asked to relinquish its status as first responder in its window.
     
     - returns: `true` if the text field is the first responder, `false`.
     */
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
        textField.font = UIFont.subhHeading
        return textField
    }()
    
    // MARK: - Functions
    
    /**
     Insert text at the index corresponding to the cursor.
     The delegate `inputViewTextDidChange:` will get colled after inserting text into the texfield.
     
     - parameter text: The text to be inserted in to TextField.
     */
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
            self.textField.textColor = Color.appColour
            
        case .valid:
            // customRightView is not required when icon is present
            self.customRightView = nil
            self.textField.icon = .tick
            self.textField.textColor = Color.appColour
            
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.delegate?.inputViewShouldBeginEditing?(inInputView: self) ?? true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.state == .normal, let rightTopView = self.customRightView {
            // hide the custom right view
            rightTopView.isHidden = true
        }
        
        self.delegate?.inputViewDidBeginEditing?(inInputView: self)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if self.state == .normal, let rightTopView = self.customRightView {
            // show the custom right view
            rightTopView.isHidden = false
            // add padding equal to width of right view
            self.textField.textFieldRightPadding = rightTopView.bounds.width
        }
        return self.delegate?.inputViewShouldEndEditing?(inInputView: self) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.inputViewDidEndEditing?(inInputView: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.delegate?.inputView?(inInputView: self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return  self.delegate?.inputViewShouldReturn?(inInputView: self) ?? true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.delegate?.inputViewShouldClear?(inInputView: self) ?? true
    }
}

/// A delegate to observe changes within `TextInputView`.
@objc public protocol TextInputViewDelegate: class {
    
    /**
     Called to perform a validation of the text field and determine if the input is valid or not.
     
     If this method is not implemented by the delegate, then validation states will not be displayed.
     
     - parameter inputView: The input view from where the delegate call originated.
     
     - returns: `true` if the input is valid, else `false`.
     */
    //@objc optional func shouldDisplayValidState(inInputView inputView: TextInputView) -> Bool
    
    /**
     Asks the delegate if editing should begin in the specified text input view.
     
     Implement this method if you want to prevent editing from happening in some situations.
     
     If you do not implement this method, the text input view acts as if this method had returned true.
     
     - parameter inputView: The input view from where the delegate call originated.
     
     - returns: `true` if editing should begin or `false` if it should not.
     */
    @objc optional func inputViewShouldBeginEditing(inInputView inputView: TextInputView) -> Bool
    
    /**
     Tells the delegate that editing began in the specified text input view.
     
     This method notifies the delegate that the specified text input view just became the first responder.
     
     Implementation of this method by the delegate is optional.
     
     - parameter inputView: The input view from where the delegate call originated.
     */
    @objc optional func inputViewDidBeginEditing(inInputView inputView: TextInputView)
    
    /**
     Asks the delegate if editing should stop in the specified text input view.
     
     - parameter inputView: The input view from where the delegate call originated.
     
     - returns: `true` if editing should stop or `false` if it should continue.
     */
    @objc optional func inputViewShouldEndEditing(inInputView inputView: TextInputView) -> Bool
    
    /**
     Tells the delegate that editing stopped for the specified text input view.
     
     - parameter inputView: The input view from where the delegate call originated.
     */
    @objc optional func inputViewDidEndEditing(inInputView inputView: TextInputView)
    
    /**
     Asks the delegate if the specified text should be changed.
     
     - parameter inputView: The input view from where the delegate call originated.
     
     - returns: `true` if the specified text range should be replaced; otherwise, `false` to keep the old text.
     */
    @objc optional func inputView(inInputView inputView: TextInputView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    /**
     Asks the delegate if the text input view should process the pressing of the return button.
     
     - parameter inputView: The input view from where the delegate call originated.
     
     - returns: `true` if the text field should implement its default behavior for the return button; otherwise, `false`.
     */
    @objc optional func inputViewShouldReturn(inInputView inputView: TextInputView) -> Bool
    
    /**
     Tells the delegate that editing changed for the input view.
     
     - parameter inputView: The input view from where the delegate call originated.
     */
    @objc optional func inputViewTextDidChange(inInputView inputView: TextInputView)
    
    /**
     Asks the delegate if the input view’s current text should be removed. Called when clear button pressed.
     
     - parameter inputView: The input view from where the delegate call originated.
     */
    @objc optional func inputViewShouldClear(inInputView inputView: TextInputView) -> Bool
}
