//
//  ObjectiveQestionView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 06/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit
struct Question {
    let title: String
    let options: [String]
}

public class ObjectiveQestionView: ViewControl {
    private var question: Question!
    
    private var elements: [SingleQuestionOptionView] = []
    public var didSelect: ((_ selectedIndex: Int, _ elements: [SingleQuestionOptionView]) -> Void)?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private  lazy var titleLabel: UILabel = { lable in
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSubHeading
        lable.textColor = Color.black1Colour
        lable.numberOfLines = 0
        return lable
    }(UILabel())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    init(question: Question) {
        self.question = question
        super.init(frame: .zero)
        self.setup()
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0.0
        return stack
    }()
    
    private func setup() {
        let titleView = UIView()
        titleView.addSubview(self.titleLabel, insets: UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0))
        self.addSubview(titleView, insets: UIEdgeInsets(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0), ignoreConstant: .bottom)
        self.titleLabel.text = self.question.title
        self.titleLabel.numberOfLines = 0
        var index = 0
        for text in self.question.options {
            let questionView = SingleQuestionOptionView(option: text, at: index)
            index += 1
            self.elements.append(questionView)
            self.stackView.addArrangedSubview(questionView)
            questionView.didSelect = { [weak self] title, index in
                self?.selectionIndex = self?.elements.firstIndex(of: questionView) ?? 0
                self?.didSelect?(self?.selectionIndex ?? 0,  self?.elements ?? [])
            }
        }
        self.addSubview(self.stackView, insets: UIEdgeInsets(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0), ignoreConstant: .top)
        self.stackView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
    }
}
