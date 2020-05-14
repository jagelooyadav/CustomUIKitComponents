//
//  TextField.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//
//

import UIKit

public class TextField: UITextField {
    
    // MARK: - Types
    
    /// A validation icon which can be displayed within the text field.
    enum Icon {
        case tick
        
        case exclamation
        
        var image: UIImage? {
            return UIImage(named: {
                switch self {
                case .tick:
                    return Constants.ImageNames.tick
                    
                case .exclamation:
                    return Constants.ImageNames.exclamation
                }
            }())
        }
    }
    
    // MARK: - Constants
    
    /// The amount of space used beeen each image when multiple views are displayed.
    private static let rightViewImageSpacing: CGFloat = 12.0
    
    // MARK: - Variables
    
    /**
     The validation icon to be displayed by the text field.
     
     The default value is `nil`.
     */
    var icon: Icon? {
        didSet {
            self.updateRightView()
        }
    }
    
    /**
     The supplementary image which is displayed by the text field.
     
     If `icon` is also set, this image will be displayed to the right of it.
     
     The default value is `nil`.
     */
    var supplementaryImage: UIImage? {
        didSet {
            self.updateRightView()
        }
    }
    
    /// Right padding for texfield
    var textFieldRightPadding: CGFloat?

    /// Holds the customized keyboard clear button title
    fileprivate var clearButtonTitle: String?
    
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

    // MARK: UITextField
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightPadding = self.textFieldRightPadding else {
            return bounds
        }
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: rightPadding))
    }
    
    override public func addSubview(_ view: UIView) {
        super.addSubview(view)
        
        // Modify the clear button when added.
        if let button = view as? UIButton {
            button.setImage(UIImage(named: Constants.ImageNames.dismiss), for: .normal)
            button.setImage(nil, for: .highlighted)
        }
    }
    
    // MARK: Private
    
    /// Performs setup of the text field.
    private func setup() {
        self.clearButtonMode = .whileEditing
        self.rightViewMode = .unlessEditing
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = Color.appColour
        self.tintColor = Color.black1Colour
    }
    
    /// Updates the content displayed in the `rightView`.
    private func updateRightView() {
        var imageViews: [UIImageView] = []
        
        // Add the icon image view, if required.
        if let icon = self.icon {
            let imageView = UIImageView(image: icon.image)
            imageView.sizeToFit()
            imageViews.append(imageView)
        }
        
        // Add the supplementary image view, if required.
        if let image = self.supplementaryImage {
            let imageView = UIImageView(image: image)
            imageView.sizeToFit()
            imageViews.append(imageView)
        }
        
        // Create a single view which represents the icon(s) to be displayed.
        let view: UIView? = {
            let count = imageViews.count
            
            if count > 1 {
                // If there are multiple image views, use a stack view.
                let stackView = UIStackView()
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.alignment = .fill
                stackView.distribution = .equalSpacing
                stackView.spacing = type(of: self).rightViewImageSpacing
                
                for imageView in imageViews {
                    stackView.addArrangedSubview(imageView)
                }
                
                return stackView
            } else if count > 0 { // swiftlint:disable:this empty_count
                // Disabling the SwiftLint rule is justifiable here as it is more effective to reuse the `count` value.
                // If there is a single image view, return this view directly.
                return imageViews.first
            } else {
                return nil
            }
        }()
        
        self.rightView = view
        self.rightViewMode = .unlessEditing
        self.textFieldRightPadding = view?.bounds.width ?? 0.0
    }
    
}

// MARK: KeyboardEventHandler

extension TextField {
    
    /// Insert a text into TextField if delgate `shouldChangeCharactersIn:` returns `true`
    private func insertTextAtCurrentPostion(text: String) {
        guard let selectedRange = self.selectedRange() else { return }
        let shouldChangeCharacter = self.delegate?.textField?(self,
                                                              shouldChangeCharactersIn: selectedRange,
                                                              replacementString: text) ?? true
        
        if shouldChangeCharacter {
            self.insertText(text)
        }
    }
    
    /// Clears the TextField text
    private func clearTextFieldText() {
        let shouldClearText = self.delegate?.textFieldShouldClear?(self) ?? true
        
        guard shouldClearText,
            let text = self.text,
            !text.isEmpty else {
                return
        }
        self.text = nil
    }
}

fileprivate extension TextField {
    /// returns the NSRange for selected text in the texfield
    func selectedRange() -> NSRange? {
        guard let textRange = self.selectedTextRange else { return nil }
        
        let location = self.offset(from: self.beginningOfDocument, to: textRange.start)
        let length = self.offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}
