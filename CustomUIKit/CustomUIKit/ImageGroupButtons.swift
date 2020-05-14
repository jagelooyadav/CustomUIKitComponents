//
//  ImageGroupButtons.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 02/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import Foundation
import UIKit

public class ImageGroupButtons: ViewControl {
    
    public var didSelect: ((_ selectedIndex: Int, _ elements: [ImageButton]) -> Void)?
    
    public var selectionIndex = 0 {
        didSet {
            guard self.selectionIndex >= 0 else { return }
            self.elements[self.selectionIndex].isSelected = true
            let selected = self.elements[self.selectionIndex]
            for element in self.elements {
                guard element != selected else { continue }
                element.isSelected = false
            }
        }
    }
    
    private var elements: [ImageButton] = []
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 16.0
        return stack
    }()
    
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    /// The title label.
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.subhHeading
        label.textColor = Color.black1Colour
        return label
    }()
    
    private lazy var underLine: UIView = {
        let vv = UIView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        vv.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        vv.backgroundColor = Color.appColour
        vv.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 1.0)
        return vv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public var images: [String]?
    public var names: [String]?
    
    public init(images: [String]?, names: [String]?) {
        self.images = images
        self.names = names
        super.init(frame: .zero)
        self.setup()
    }
    
    private func setup() {
        self.verticalStack.addArrangedSubview(self.titleLabel)
        self.verticalStack.addArrangedSubview(self.stackView)
        self.addSubview(self.verticalStack, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0.0, right: 16), ignoreConstant: .right)
        guard let images = self.images, let names = self.names else { return }
        
        let buttons: [ImageButton] = images.map { image -> ImageButton in
            let button = ImageButton()
            button.buttonImage = UIImage(named: image)
            return button
        }
        let updated = buttons.map { button -> ImageButton in
            if let firstIndex = buttons.firstIndex(of: button) {
                button.title = names[firstIndex]
            }
            return button
        }
        self.addElements(updated)
    }
    
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
    public func addElements(_ elements: [ImageButton]) {
        for element in elements {
            self.stackView.addArrangedSubview(element)
            element.didSelect = { [weak self] button in
                self?.selectionIndex = elements.firstIndex(of: element) ?? 0
                self?.didSelect?(self?.selectionIndex ?? 0, elements)
            }
        }
        
        self.elements = elements
        self.selectionIndex = -1
    }
}
