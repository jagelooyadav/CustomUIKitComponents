//
//  ViewController.swift
//  ComponentTestApp
//
//  Created by Jageloo Yadav on 02/01/22.
//

import UIKit
import CustomUIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom Componets"
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        self.scrollingContentView.addSubview(stack)
        stack.anchorToSuperView(bottomRelation: .greaterOrEqual,
                                leading: 20.0,
                                trailing: 20.0,
                                top: 0)
        
        let label = UILabel()
        label.text = "Buttons"
        label.font = UIFont.bigBrother
    
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(createButton(type: .bordered, color: .blue))
        stack.addArrangedSubview(createButton(type: .plane, color: .blue))
        
        stack.addArrangedSubview(createButton(type: .bordered, color: Color.darkRed))
        stack.addArrangedSubview(createButton(type: .plane, color: Color.darkRed))
        
        stack.addArrangedSubview(createButton(type: .bordered, color: .green))
        stack.addArrangedSubview(createButton(type: .plane, color: .green))
    
        
        stack.addArrangedSubview(createButtonCodeSample())
    }
    
    func createButton(type: Button.ButtonType, color: UIColor) -> Button {
        let button = Button()
        button.customType = type
        button.primaryColor = color
        let title = type == .bordered ? "Bordered button" : "Plane Button"
        button.setTitle(title, for: .normal)
        return button
    }
    
    func createButtonCodeSample() -> UIView {
        let html = """
        
        <HTML>
        <head>
        <style>
            .tab {
                display: inline-block;
                margin-left: 40px;
            }
        </style>
        </head>
        <Body style = "font-size: 20px">
            <b>func createButton(type: Button.ButtonType, color: UIColor) -> Button {</b><BR><BR>
                <i>
                <p style = "margin-left: 40px; background-color:clear;">
                let button = Button()<Br>
                button.customType = type <Br>
                button.primaryColor = color <Br>
                let title = type == .bordered ? "Bordered button" : "Plane Button" <Br>
                button.setTitle(title, for: .normal) <Br>
                return button1
                </p>
                </i>
            </b>}</b>
            <BR>createButton(type: .bordered, color: .blue)
            <BR>createButton(type: .plane, color: .blue)
        </Body>
        </HTML>
        """
        let htmlData = NSString(string: html).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html]
        let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                              options: options,
                                                              documentAttributes: nil)
        let codeSample = UILabel()
        codeSample.numberOfLines = 0
        codeSample.textColor = .black
        codeSample.attributedText = attributedString
        return codeSample
    }
    
    override var shouldEmbedInScrollView: Bool {
        return true
    }
}
