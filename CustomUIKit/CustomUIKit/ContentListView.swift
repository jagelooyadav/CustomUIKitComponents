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
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }
    
    public lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }()
    
    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        self.renderView()
        self.backgroundColor = Color.grey4Colour
    }
    
    public func renderView() {
        let contentView = UIView()
        self.addSubview(contentView, insets: UIEdgeInsets(top: 16, left: 16, bottom: 0.0, right: 16.0))
        contentView.addSubview(self.verticalStack, insets: .zero)
        var number = 1
        for item in self.items {
            let sequence = UILabel()
            sequence.textColor = Color.darkTextColour
            sequence.font = UIFont.body
            sequence.text = "\(number)."
            let hStack = self.stackView
            hStack.spacing = 16
            hStack.addArrangedSubview(sequence)
            let text = UILabel()
            text.text = item
            text.font = UIFont.body
            text.textColor = Color.darkTextColour
            hStack.addArrangedSubview(text)
            self.verticalStack.addArrangedSubview(hStack)
            number += 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
