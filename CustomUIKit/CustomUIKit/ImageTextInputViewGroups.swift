//
//  ImageTextInputViewGroups.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 09/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit
public struct ImageData {
    public var title: String?
    public var icon: String?
    public var identifier: String?
}
public class ImageTextInputViewGroups: ViewControl {
    
    public var fruitJuiceImageInput: ImageInputTextView?
    public var fruitImageInput: ImageInputTextView?
    public var potatoesInput: ImageInputTextView?
    public var vegitablesInput: ImageInputTextView?
    
    private var iconDataList: [ImageData]?
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 16.0
        return stack
    }()
    
    public lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    public var parntView: UIView!
    
    public init(iconDataList: [ImageData]?) {
        self.iconDataList = iconDataList
        super.init(frame: .zero)
        self.setup()
    }
    
    /// The title label.
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSubHeading
        label.textColor = Color.black1Colour
        return label
    }()
    
    private lazy var underLine: UIView = {
        let vv = UIView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        vv.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        vv.backgroundColor = Appearance.color
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
    
    private func setup() {
        let contentView = UIView()
        let wrapperView = UIView()
        self.addSubview(self.titleLabel, insets: UIEdgeInsets(top: 0.0, left: 16, bottom: 0.0, right: 16), ignoreConstant: .bottom)
        self.addSubview(wrapperView, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0.0, right: 16), ignoreConstant: .top)
        wrapperView.addSubview(self.scrollView, insets: .zero)
        self.scrollView.addSubview(contentView, insets: .zero)
        contentView.addSubview(self.stackView, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0.0, right: 16))
        contentView.widthAnchor.constraint(greaterThanOrEqualTo: wrapperView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: wrapperView.heightAnchor).isActive = true
        wrapperView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20.0).isActive = true
        
        guard let imageDataList = self.iconDataList else { return }
        for imageData in imageDataList {
            let imageView = ImageInputTextView()
            imageView.title = imageData.title
            if let image = imageData.icon {
                imageView.icon = UIImage(named: image)
            }
            guard let identifier = imageData.identifier  else { continue }
            
            switch identifier {
            case "fruitJuice":
                self.fruitJuiceImageInput = imageView
            case "fruit":
                self.fruitImageInput = imageView
            case  "potatoes":
                self.potatoesInput = imageView
            case "vegitables":
                self.vegitablesInput = imageView
            default:
                break
            }
            self.stackView.addArrangedSubview(imageView)
        }
    }
    
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
    public func addElements(_ elements: [ImageInputTextView]) {
        for element in elements {
            self.stackView.addArrangedSubview(element)
        }
    }
}
