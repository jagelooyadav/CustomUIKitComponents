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
        stack.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                 bottomRelation: .greaterOrEqual,
                                 leading: 20.0,
                                 trailing: 20.0,
                                 top: 0)
        
        let label = UILabel()
        label.text = "Buttons"
    
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(createButton(type: .bordered, color: .blue))
        stack.addArrangedSubview(createButton(type: .plane, color: .blue))
        
        stack.addArrangedSubview(createButton(type: .bordered, color: Color.darkRed))
        stack.addArrangedSubview(createButton(type: .plane, color: Color.darkRed))
        
        stack.addArrangedSubview(createButton(type: .bordered, color: .yellow))
        stack.addArrangedSubview(createButton(type: .plane, color: .yellow))
    }
    
    func createButton(type: Button.ButtonType, color: UIColor) -> Button {
        let button1 = Button()
        button1.customType = type
        button1.primaryColor = color
        let title = type == .bordered ? "Bordered button" : "Plane Button"
        button1.setTitle(title, for: .normal)
        return button1
    }
    
    override var shouldEmbedInScrollView: Bool {
        return true
    }
}

