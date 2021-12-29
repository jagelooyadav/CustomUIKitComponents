//
//  ObjectiveQestionView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 06/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit
public struct Question {
    public let title: String
    public let options: [String]
    
    public init(title: String, options: [String]) {
        self.title = title
        self.options = options
    }
}

public class ObjectiveQestionView: ViewControl, ShadowProvider {
    public var containerView: UIView! {
        return self
    }
    
    private var question: Question!
    
    private var elements: [SingleQuestionOptionView] = []
    public var didSelect: ((_ selectedIndex: Int, _ elements: [SingleQuestionOptionView]) -> Void)?
    public var didSelectM: ((_ selectedIndex: Int, _ status: Bool) -> Void)?
    
    public var isMultipleSelection = false
    
    public var selectedIndexes: [Int] = []
    
    public var selectionIndex = -1 {
        didSet {
            guard self.selectionIndex >= 0 else { return }
            
            if self.isMultipleSelection {
                let selected = self.elements[self.selectionIndex]
                self.elements[self.selectionIndex].isSelected = !selected.isSelected
                if self.elements[self.selectionIndex].isSelected, !self.selectedIndexes.contains(self.selectionIndex) {
                    self.selectedIndexes.append(self.selectionIndex)
                } else {
                    guard let index = self.selectedIndexes.firstIndex(of: self.selectionIndex) else { return }
                    self.selectedIndexes.remove(at: index)
                }
            } else {
                self.elements[self.selectionIndex].isSelected = true
                let selected = self.elements[self.selectionIndex]
                for element in self.elements {
                    guard element != selected else { continue }
                    element.isSelected = false
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public lazy var titleLabel: UILabel = { lable in
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.sfBoldBody
        lable.textColor = .black
        lable.numberOfLines = 0
        return lable
    }(UILabel())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public init(question: Question) {
        self.question = question
        super.init(frame: .zero)
        self.setup()
    }
    
    public lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0.0
        return stack
    }()
    
    private func setup() {
        let containerView = UIView()
        let titleView = UIView()
        titleView.backgroundColor = .clear
        titleView.addSubview(self.titleLabel, insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
        containerView.addSubview(titleView, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0), ignoreConstant: .bottom)
        self.titleLabel.text = self.question.title
        self.titleLabel.numberOfLines = 0
        var index = 0
        for text in self.question.options {
            let questionView = SingleQuestionOptionView(option: text, at: index)
            index += 1
            self.elements.append(questionView)
            self.stackView.addArrangedSubview(questionView)
            questionView.didSelect = { [weak self] title, index in
                guard let selfS = self, !selfS.isMultipleSelection else { return }
                self?.selectionIndex = self?.elements.firstIndex(of: questionView) ?? 0
                self?.didSelect?(self?.selectionIndex ?? 0,  self?.elements ?? [])
            }
            questionView.didSelectM = { [weak self] title, index, status in
                self?.selectionIndex = self?.elements.firstIndex(of: questionView) ?? 0
                self?.didSelectM?(self?.selectionIndex ?? 0,  status)
            }
            
        }
        containerView.addSubview(self.stackView, insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 16.0, right: 0.0), ignoreConstant: .top)
        self.stackView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
        self.backgroundColor = .clear
        self.stackView.backgroundColor = .clear
        containerView.layer.cornerRadius = 20.0
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        self.addSubview( containerView, insets: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0, right: 16.0))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.dropShadow()
    }
}
