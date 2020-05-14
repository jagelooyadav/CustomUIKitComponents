//
//  Color.swift
//  CustomUIKit
//
//  Created by Ganesh Waje on 07/06/2017.
//
//

import UIKit

public class Color: NSObject {
    
    // Prevent instantiation.
    private override init() { }
    
    /**
     # Dark Blue Colour
     
     #00395D
     
     ## Example usages
     
     - Main title
     - Secondary title
     - Tertiary title
     - Offer amounts
     - Button pressed
     */
    @objc public static let darkBlueColour = UIColor(actualRed: 41, green: 51, blue: 10)
    
    /**
     # Digital Blue Colour
     
     #0076B6
     
     ## Example usages
     
     - Navigation bar
     - Link text
     - Button active
     - Radio, checkbox, toggle selected text
     */
    @objc public static let appColour = UIColor(actualRed: 100, green: 208, blue: 249)
    
    /**
     # Light Blue Colour
     
     #B2D6E9
     
     ## Example usages
     
     - Button disabled
     */
    @objc public static let lightBlueColour = UIColor(actualRed: 41, green: 81, blue: 40)
    
    /**
     # Step Blue Colour
     
     #B2D6E9
     
     ## Example usages
     
     - Steps view
     */
    @objc public static let stepBlueColour = UIColor(actualRed: 178.0, green: 214.0, blue: 233.0)
    
    /**
     # Dark Red Colour
     
     #9D063B
     
     ## Example usages
     
     - Button background
     */
    @objc public static let darkRedColour = UIColor(actualRed: 157.0, green: 6.0, blue: 59.0)
    
    /**
     # Light Red Colour
     
     #FAEAEA
     
     ## Example usages
     
     - Disabled Button background
     */
    @objc public static let lightRedColour = UIColor(actualRed: 250.0, green: 234.0, blue: 234.0)
    
    /**
     # Dark Text Colour
     
     #333333
     
     ## Example usages
     
     - Body copy
     - Account balances
     */
    @objc public static let darkTextColour = UIColor(actualColorValue: 51.0)
    
    /**
     # Light Text Colour
     
     #666666
     
     ## Example usages
     
     - Radio
     - Account balance labels
     - Radio, checkbox, toggle de-selected text
     */
    @objc public static let lightTextColour = UIColor(actualColorValue: 102.0)
    
    /**
     # Grey 1 Colour
     
     #8C8C8C
     
     ## Example usages
     
     - Main title
     - Secondary title
     - Tertiary title
     */
    @objc public static let grey1Colour = UIColor(actualColorValue: 140.0)
    
    /**
     # Grey 2 Colour
     
     #B2B2B2
     
     ## Example usages
     
     - Chevron
     - Radio, checkbox, toggle de-selected outer
     - Disabled text
     */
    @objc public static let grey2Colour = UIColor(actualColorValue: 178.0)
    
    /**
     # Grey 3 Colour
     
     #D7D7D7
     
     ## Example usages
     
     - Divider dark
     - Radio, checkbox, toggle disabled outer
     */
    @objc public static let grey3Colour = UIColor(actualColorValue: 215.0)
    
    /**
     # Grey 4 Colour
     
     #F7F5F4 and colour id is "taupe4"
     
     ## Exampel usages
     
     - Page background
     - Divider light
     - Toggle de-selected inner
     */
    @objc public static let grey4Colour = UIColor(actualRed: 247.0, green: 245.0, blue: 244.0)
    
    /**
     # Label Green Colour
     
     #E6F3E8
     
     ## Example usages
     
     - Badge 'need to activate' background colour
     */
    @objc public static let labelGreenColour = UIColor(actualRed: 230.0, green: 243.0, blue: 232.0)
    
    /**
     # Label Orange Colour
     
     #DC630A
     
     ## Example usages
     
     - Account expiry warning color
     */
    @objc public static let labelOrangeColour = UIColor(actualRed: 220.0, green: 99.0, blue: 10.0)
    
    /**
     Provides the colour associated with the given style.
     # Label Dark Grey1 Colour
     
     # #Colour ID and Colour Hex Code "darkGreyTint1" and "#8D8D8D"
     
     */
    @objc public static let darkGrey1Colour = UIColor(actualRed: 141.0, green: 141.0, blue: 141.0)
    
    /**
     # Label Dark Grey3 Colour
     
     # #Colour ID and Colour Hex Code "darkGreyTint3" and "#D9D9D9"
     */
    @objc public static let darkGrey3Colour = UIColor(actualRed: 217.0, green: 217.0, blue: 217.0)
    
    /**
     # Dark Grey4 Colour
     
     #Colour ID and Colour Hex Code "darkGreyTint4" and "#EFEFEF"
     
     ## Example usages
     
     - Brand logo border colour
     */

    public static let darkGrey4Colour = UIColor(actualRed: 239.0, green: 239.0, blue: 239.0)
    
    /**
     # Dark Grey5 Colour
     
     #Colour ID and Colour Hex Code "darkGreyTint5" and "#F7F7F7"
     */
    public static let darkGrey5Colour = UIColor(actualRed: 247.0, green: 247.0, blue: 247.0)
    
    /**
     # Black1 Colour
     
     #Colour ID and Colour Hex Code "blackTint1" and "#404040"
     */
    public static let black1Colour = UIColor(actualRed: 64.0, green: 64.0, blue: 64.0)
    
    /**
     # Black2 Colour
     
     #Colour ID and Colour Hex Code "blackTint2" and "#7F7F7F"
     */
    public static let black2Colour = UIColor(actualRed: 127.0, green: 127.0, blue: 127.0)
    
    /**
     # Black3 Colour
     
     #Colour ID and Colour Hex Code "blackTint3" and "#BFBFBF"
     */
    public static let black3Colour = UIColor(actualRed: 191.0, green: 191.0, blue: 191.0)
    
    /**
     # Black4 Colour
     
     #Colour ID and Colour Hex Code "blackTint4" and "#E5E5E5"
     */
    public static let black4Colour = UIColor(actualRed: 229.0, green: 229.0, blue: 229.0)
    
    /**
     # Black5 Colour
     
     #Colour ID and Colour Hex Code "blackTint5" and "#F2F2F2"
     */
    public static let black5Colour = UIColor(actualRed: 242.0, green: 242.0, blue: 242.0)
    
    /**
     # Super markets Category Colour
     
     #Colour ID and Colour Hex Code "supermarkets" and "#FFBE10"
     
     ## Example usages
     
     - Brand logo shopping category colour
     */
    public static let supermarketsSpendCategoryColour = UIColor(actualRed: 255.0, green: 190.0, blue: 16.0)
    
    /**
     # Personal Category Colour
     
     #Colour ID and Colour Hex Code "personal" and "#9D063B"
     
     ## Example usages
     
     - Brand logo personal category colour
     */
    public static let personalSpendCategoryColour = UIColor(actualRed: 157.0, green: 6.0, blue: 59.0)
    /**
     # Other Category Colour
     
     #Colour ID and Colour Hex Code "other" and "#B1A194"
     
     ## Example usages
     
     - Brand logo other category colour
     */
    public static let otherSpendCategoryColour = UIColor(actualRed: 177.0, green: 161.0, blue: 148.0)
    /**
     # Warning Colour
     
     #c55200
     
     ## Example usages
     
     - Warning copy
     */
    @objc public static let warningColour = UIColor(actualRed: 197.0, green: 82.0, blue: 0.0)
    
    /**
     # White Colour
     
     #FFFFFF
     
     ## Example usages
     
     - Numeric input field background colour for PINSentry
     */
    @objc public static let whiteColour = UIColor(actualRed: 255.0, green: 255.0, blue: 255.0)
}
