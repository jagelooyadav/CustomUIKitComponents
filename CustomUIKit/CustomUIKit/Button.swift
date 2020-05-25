//
//  Button.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 22/11/2019.
//

import UIKit
 
public class Button: UIButton {
    
    // MARK: - Constants
    
    /// The height of the regular button.
    private static let height: CGFloat = 48.0
    
    /// The border width of the button.
    private static let borderWidth: CGFloat = 1.0
    
    private static let cornerRadius: CGFloat = 24.0
    
    // MARK: - Type Alias
    
    /// A tuple which contains the various colours to be used by the button.
    private typealias Colours = (
        activeText: UIColor,
        activeBackground: UIColor,
        activeBorder: UIColor?,
        pressedText: UIColor,
        pressedBackground: UIColor,
        pressedBorder: UIColor?,
        disabledText: UIColor,
        disabledBackground: UIColor,
        disabledBorder: UIColor?
    )
    
    // MARK: - Enums
    
    /// A style of the button.
    public enum Style {
        /// Primary style.
        case primary
        
        /// Secondary style.
        case secondary
        
        /// Delete button style.
        case delete
    }
    
    // MARK: - Variables
    
    /**
     The button style.
     
     Defaults to `primary`.
     */
    public var style: Style = .primary {
        didSet {
            self.updateColours()
        }
    }
    
    /// The colours to be used by the button.
    private var colours: Colours?
    
    /// The height constraint of button
    private weak var heightConstraint: NSLayoutConstraint?
    
    /**
     Determines if the button uses the secondary style or not.
     
     - Important:
     This is a convenience variable to set `style`, designed only for Objective-C and IBInspectable usage.
     If you are using Swift, directly set `style` instead for better performance.
     */
    @IBInspectable var isSecondaryStyle: Bool {
        get {
            return self.style == .secondary
        }
        
        set {
            self.style = newValue ? .secondary : .primary
        }
    }
    
    // ⚠️ Don't remove the explicit type decleration - it's needed for IBInspectable to work.
    /// Determines if the initial titles of the button should be localised.
    @IBInspectable var localiseTitles: Bool = false
    
    override public var isHighlighted: Bool {
        didSet {
            self.updateCurrentAppearance()
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            self.updateCurrentAppearance()
        }
    }
    
    // MARK: - Initialisers
    
    /**
     Creates a new button with the given style.
     
     - parameter style: The button style.
     */
    public init(style: Style) {
        super.init(frame: .zero)
        
        self.style = style
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    // MARK: - UIButton
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.updateColours()
        
        if self.localiseTitles {
            for state in [.normal, .selected, .disabled, .selected, .focused, .application] as [UIControl.State] {
                guard let title = self.title(for: state) else { continue }
                self.setTitle(title, for: state)
            }
        }
    }
    
    // MARK: - Private Functions
    
    /// Performs an initial setup of the button.
    private func setup() {
        let selfType = type(of: self)
        
        self.clipsToBounds = true
        self.layer.borderWidth = selfType.borderWidth
        self.layer.cornerRadius = selfType.cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: selfType.height)
        self.heightConstraint?.isActive = true
        
        self.updateColours()
    }
    
    /// Updates the defined colours based upon the style.
    private func updateColours() {
        let colours: Colours = {
            switch self.style {
            case .primary:
                let white = UIColor.white
                
                return (activeText: white, activeBackground: Appearance.color,
                        activeBorder: nil,
                        pressedText: white, pressedBackground: Color.darkBlueColour,
                        pressedBorder: nil,
                        disabledText: white, disabledBackground: Color.lightBlueColour.withAlphaComponent(0.5),
                        disabledBorder: nil)
                
            case .secondary:
                let white = UIColor.white
                let darkBlue = Color.darkBlueColour
                let lightBlue = Color.lightBlueColour
                let digitalBlue = Appearance.color
                
                return (activeText: digitalBlue, activeBackground: white,
                        activeBorder: digitalBlue,
                        pressedText: darkBlue, pressedBackground: lightBlue,
                        pressedBorder: darkBlue,
                        disabledText: white, disabledBackground: lightBlue,
                        disabledBorder: nil)
                
            case .delete:
                let white = UIColor.white
                
                return (activeText: white, activeBackground: .red,
                        activeBorder: nil,
                        pressedText: white, pressedBackground: Color.darkRedColour,
                        pressedBorder: nil,
                        disabledText: white, disabledBackground: Color.lightRedColour.withAlphaComponent(0.5),
                        disabledBorder: nil)
            }
        }()
        
        self.colours = colours
        
        self.setTitleColor(colours.activeText, for: .normal)
        self.setTitleColor(colours.pressedText, for: .highlighted)
        self.setTitleColor(colours.disabledText, for: .disabled)
        
        self.updateCurrentAppearance()
    }
    
    /// Updates the current appearance for the button state.
    private func updateCurrentAppearance() {
        guard let colours = self.colours else { return }
        
        if !self.isEnabled {
            self.backgroundColor = colours.disabledBackground
            self.layer.borderColor = (colours.disabledBorder ?? colours.disabledBackground).cgColor
        } else if self.isHighlighted {
            self.backgroundColor = colours.pressedBackground
            self.layer.borderColor = (colours.pressedBorder ?? colours.pressedBackground).cgColor
        } else {
            self.backgroundColor = colours.activeBackground
            self.layer.borderColor = (colours.activeBorder ?? colours.activeBackground).cgColor
        }
    }
    
}
