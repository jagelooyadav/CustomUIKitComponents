//
//  TextInputView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//
//

import UIKit

public class TextInputView: InputView {
    
    @objc public weak var delegate: TextInputViewDelegate? {
        didSet {
            self.textField.delegate = self.delegate != nil ? self : nil
        }
    }

    public var textFieldTextColor: UIColor? {
        didSet {
            self.textField.textColor = self.textFieldTextColor ?? self.textField.textColor
        }
    }

    public var textFieldInvalidTextColor: UIColor? = Color.darkRed {
        didSet {
            self.textField.textColor = self.textFieldInvalidTextColor ?? self.textField.textColor
        }
    }

    public var isEnabled: Bool {
        get {
            return self.textField.isEnabled
        }
        
        set {
            self.textField.isEnabled = newValue
        }
    }

    @objc public var placeholder: String? {
        get {
            return self.textField.placeholder
        }
        set {
            self.textField.placeholder = newValue
            
        }
    }

    @objc public var textFieldInputView: UIView? {
        get {
            return self.textField.inputView
        }
        
        set {
            self.textField.inputView = newValue
        }
    }
 
    @objc public var textFieldInputAccessoryView: UIView? {
        get {
            return self.textField.inputAccessoryView
        }
        
        set {
            self.textField.inputAccessoryView = newValue
        }
    }
 
    @objc public var keyboardType: UIKeyboardType {
        get {
            return self.textField.keyboardType
        }
        
        set {
            self.textField.keyboardType = newValue
        }
    }
   
    @objc public var autocorrectionType: UITextAutocorrectionType {
        get {
            return self.textField.autocorrectionType
        }
        
        set {
            self.textField.autocorrectionType = newValue
        }
    }

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
    
            oldValue?.removeFromSuperview()
            
            guard let newValue = self.customRightView else { return }
     
            self.addSubview(newValue)
            newValue.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newValue.topAnchor.constraint(equalTo: self.textField.topAnchor, constant: 0.0),
                self.textField.bottomAnchor.constraint(equalTo: newValue.bottomAnchor, constant: 0.0),
                newValue.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor, constant: 0.0)
                ])
            
        }
    }
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

    @objc override public var valueView: UIView? {
        return self.textField
    }
    
    override public func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
   
    @discardableResult override public func resignFirstResponder() -> Bool {
        return self.textField.resignFirstResponder()
    }
 
    override public var isFirstResponder: Bool {
        return self.textField.isFirstResponder
    }

    @IBInspectable public var placeholderLocalisationKey: String? {
        didSet {
            guard let key = self.placeholderLocalisationKey else { return }
            
            self.placeholder = key
        }
    }
    @IBInspectable public var isSecureTextEntry: Bool {
        get {
            return self.textField.isSecureTextEntry
        }
        
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }
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

    @objc private func textFieldTextDidChange() {
        
        self.delegate?.inputViewTextDidChange?(inInputView: self)
    }
    
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
            self.textField.textColor = Color.grey2
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
