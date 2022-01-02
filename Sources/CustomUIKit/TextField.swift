//
//  TextField.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//
//

import UIKit

public class TextField: UITextField {
 
    public enum Icon {
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

    private static let rightViewImageSpacing: CGFloat = 12.0
   
    public var icon: Icon? {
        didSet {
            self.updateRightView()
        }
    }
   
    public var supplementaryImage: UIImage? {
        didSet {
            self.updateRightView()
        }
    }
 
    public var textFieldRightPadding: CGFloat?

    fileprivate var clearButtonTitle: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
  
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightPadding = self.textFieldRightPadding else {
            return bounds
        }
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: rightPadding))
    }
    
    override public func addSubview(_ view: UIView) {
        super.addSubview(view)
   
        if let button = view as? UIButton {
            button.setImage(UIImage(named: Constants.ImageNames.dismiss), for: .normal)
            button.setImage(nil, for: .highlighted)
        }
    }
 
    private func setup() {
        self.clearButtonMode = .whileEditing
        self.rightViewMode = .unlessEditing
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = Appearance.color
        self.tintColor = Color.black1Colour
    }

    private func updateRightView() {
        var imageViews: [UIImageView] = []
      
        if let icon = self.icon {
            let imageView = UIImageView(image: icon.image)
            imageView.sizeToFit()
            imageViews.append(imageView)
        }
     
        if let image = self.supplementaryImage {
            let imageView = UIImageView(image: image)
            imageView.sizeToFit()
            imageViews.append(imageView)
        }
        let view: UIView? = {
            let count = imageViews.count
            
            if count > 1 {
             
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
            } else if count > 0 {
                
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

    private func insertTextAtCurrentPostion(text: String) {
        guard let selectedRange = self.selectedRange() else { return }
        let shouldChangeCharacter = self.delegate?.textField?(self,
                                                              shouldChangeCharactersIn: selectedRange,
                                                              replacementString: text) ?? true
        
        if shouldChangeCharacter {
            self.insertText(text)
        }
    }

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
    func selectedRange() -> NSRange? {
        guard let textRange = self.selectedTextRange else { return nil }
        
        let location = self.offset(from: self.beginningOfDocument, to: textRange.start)
        let length = self.offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}
