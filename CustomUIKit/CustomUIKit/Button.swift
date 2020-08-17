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
    
    public var primaryColor = UIColor.init(actualRed: 237.0, green: 63.0, blue: 110.0) {
        didSet {
            self.updateColours()
            self.updateCurrentAppearance()
        }
    }
    
    // MARK: - Enums
    
    /// A style of the button.
    public enum Style: String {
        /// Primary style.
        case primary
        
        /// Secondary style.
        case secondary
        
        /// Delete button style.
        case delete
        
        /// Underline
        
        case underline

    }
    
    // MARK: - Variables
    
    /**
     The button style.
     
     Defaults to `primary`.
     */
    public var style: Style = .primary {
        didSet {
            self.gradient.removeFromSuperlayer()
            self.updateColours()
        }
    }
    public let gradient = CAGradientLayer()
    public var primaryGradientColors: [CGColor] = [] {
        didSet {
            gradient.frame = self.bounds
            gradient.colors = self.primaryGradientColors
            gradient.startPoint = CGPoint(x: 0.0, y: 0.50)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.50)
            self.layer.insertSublayer(gradient, at: 0)
            self.layer.cornerRadius = 24.0
            self.clipsToBounds = true
            self.backgroundColor = .clear
            self.layer.borderColor = UIColor.clear.cgColor
            self.setTitleColor(.white, for: .normal)
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
    @IBInspectable var styleString: String {
        get {
            return ""
        }
        
        set {
            self.style = Style(rawValue: newValue) ?? .primary
            self.updateCurrentAppearance()
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
        self.titleLabel?.font = UIFont.boldBody
    }
    
    /// Updates the defined colours based upon the style.
    private func updateColours() {
        guard self.primaryGradientColors.isEmpty else { return }
        let colours: Colours = {
            switch self.style {
            case .primary:
                let white = UIColor.white
                
                return (activeText: white, activeBackground: self.primaryColor,
                        activeBorder: nil,
                        pressedText: white, pressedBackground: self.primaryColor.withAlphaComponent(0.8),
                        pressedBorder: nil,
                        disabledText: self.primaryColor, disabledBackground: self.primaryColor.withAlphaComponent(0.5),
                        disabledBorder: nil)
                
            case .secondary, .underline:
                let white = UIColor.white
                let darkBlue = Color.darkBlueColour
                let lightBlue = self.primaryColor == .clear ? Color.grey1Colour : self.primaryColor.withAlphaComponent(0.8)
                let digitalBlue = self.primaryColor == .clear ? Color.grey1Colour : self.primaryColor
                
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

        if self.primaryColor == .clear && self.style != .primary {
            self.setTitleColor(Color.darkGrey3Colour, for: .disabled)
        }
        self.updateCurrentAppearance()
    }
    
    /// Updates the current appearance for the button state.
    private func updateCurrentAppearance() {
        guard let colours = self.colours else { return }
        guard self.primaryGradientColors.isEmpty else { return }
        
        if !self.isEnabled {
            self.backgroundColor = self.style == .secondary ? colours.disabledBackground : UIColor.white
            self.layer.borderColor = (colours.disabledBorder ?? colours.disabledBackground).cgColor
        } else if self.isHighlighted {
            self.backgroundColor = colours.pressedBackground
            self.layer.borderColor = (colours.pressedBorder ?? colours.pressedBackground).cgColor
        } else {
            self.backgroundColor = colours.activeBackground
            self.layer.borderColor = (colours.activeBorder ?? colours.activeBackground).cgColor
            
        }
        if self.primaryColor == .clear {
            self.layer.borderColor = Color.grey3Colour.cgColor
        }
        if self.style == .underline {
            self.layer.borderColor = UIColor.clear.cgColor
            self.backgroundColor = .clear
             self.setTitleColor(Color.black1Colour, for: .normal)
            self.layer.borderWidth = 0.0
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
}
