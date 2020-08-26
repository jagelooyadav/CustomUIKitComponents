//
//  ContentListView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 12/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public class ContentListView: UIView {
    var items: [String] = []
    
    private  var stackView: UIStackView {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }
    
    public lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 16.0
        return stack
    }()
    
    public init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        self.renderView()
        self.backgroundColor = Color.grey4Colour
    }
    
    public func renderView() {
        let contentView = UIView()
        self.addSubview(contentView, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16.0, right: 16.0))
        contentView.addSubview(self.verticalStack, insets: .zero)
        var number = 1
        for item in self.items {
            let sequence = UILabel()
            let sequenceView = UIView()
            sequenceView.addSubview(sequence, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 16.0))
            sequenceView.translatesAutoresizingMaskIntoConstraints = false
            sequenceView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
            sequence.textColor = Color.darkTextColour
            sequence.font = UIFont.body
            sequence.text = "○"
            let hStack = self.stackView
            hStack.spacing = 0
            hStack.addArrangedSubview(sequenceView)
            let text = UILabel()
            
            let view = UIView()
            view.addSubview(text, insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), ignoreConstant: .right)
            view.trailingAnchor.constraint(greaterThanOrEqualTo: text.trailingAnchor).isActive  = true
            
            view.backgroundColor = .clear
            text.numberOfLines = 0
            text.text = item
            text.font = UIFont.body
           
            text.textColor = Color.darkTextColour
            hStack.addArrangedSubview(view)
            self.verticalStack.addArrangedSubview(hStack)
            number += 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
}
