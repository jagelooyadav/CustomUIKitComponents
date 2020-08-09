//
//  PageView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 11/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit
import Foundation

public protocol PageViewDelegate: class {
    func didSelectQuestion(questionIdex: Int, questionView: ObjectiveQestionView)
    func placeholderView(forIdentifier id: String?) -> UIView?
}

public extension PageViewDelegate {
    func didSelectQuestion(questionIdex: Int, questionView: ObjectiveQestionView) {}
    func placeholderView(forIdentifier id: String?) -> UIView? { return nil }
}

public class PageView: ViewControl {
    
    public var expectationBox: RoundedInformationBox?
    public var sexGroups: ImageGroupButtons?
    public var yourAgeInputTextView: TextInputView?
    public var nextButton: Button?
    public var smokingQuestionView: ObjectiveQestionView?
    public var didYouSmokeInPastQuestionView: ObjectiveQestionView?
    public var cigratesPerDayTextInputView: TextInputView?
    public var ageOnCigrateStartTextInputView: TextInputView?
    public var alchohalOptionsQuestionView: ObjectiveQestionView?
    public var drinksIPastTextInputView: TextInputView?
    public var imageInputGroups: ImageTextInputViewGroups?
    
    private var footerTopConstraint: NSLayoutConstraint?
    private var contentStackBottomConstraint: NSLayoutConstraint?
    
    public var viewInfo: [String?: AnyObject] = [:]
    
    public weak var delegate: PageViewDelegate?
    
    @objc public var footerButtonPress: (() -> Void)?
    
    public lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    
    public var footerParentView = UIView()
    
    private let content: ContentData
    
    public init(content: ContentData, isQuestionViewVetically: Bool = true) {
        self.content = content
        self.isQuestionViewVetically = isQuestionViewVetically
        super.init(frame: .zero)
        self.setup()
    }
    
    private var isQuestionViewVetically: Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIForDynamicContent() {
        for content in self.content.contents {
            switch content.resourceType {
                
            case .RoundedInformationBox:
                let box = RoundedInformationBox()
                box.title = content.title
                self.contentStackView.addArrangedSubview(box)
                self.expectationBox = box
                self.viewInfo[content.identifier] = box
                
            case .HeadingWithSeperator:
                let heding = HeadingWithSeperator(withString: content.title)
                self.contentStackView.addArrangedSubview(heding)
                self.viewInfo[content.identifier] = heding
                
            case .ImageGroupButtons:
                let groups = ImageGroupButtons(images: content.images, names: content.names)
                self.contentStackView.addArrangedSubview(groups)
                self.sexGroups = groups
                self.viewInfo[content.identifier] = groups
                
            case .TextInputView:
                self.configureTextInputView(content: content)
                
            case .ObjectiveQestionView:
                let question = Question(title: content.title, options: content.contents.map { $0.title })
                let questionsView = ObjectiveQestionView.init(question: question)
                self.contentStackView.addArrangedSubview(questionsView)
                if !self.isQuestionViewVetically {
                    questionsView.stackView.distribution = .fillEqually
                    questionsView.stackView.axis = .horizontal
                }
                if content.isContentVetical == true {
                    questionsView.stackView.distribution = .fill
                    questionsView.stackView.axis = .vertical
                }
                if content.identifier == "smokingOption" {
                    self.smokingQuestionView = questionsView
                } else if content.identifier == "didYouSmokeDaily" {
                    self.didYouSmokeInPastQuestionView = questionsView
                } else if "alchohalOption" == content.identifier {
                    self.alchohalOptionsQuestionView = questionsView
                }
                questionsView.didSelect = { index, _ in
                    self.delegate?.didSelectQuestion(questionIdex: index, questionView: questionsView)
                }
                questionsView.didSelectM = { index, _ in
                    self.delegate?.didSelectQuestion(questionIdex: index, questionView: questionsView)
                }
                questionsView.identifier = content.identifier
                self.viewInfo[content.identifier] = questionsView
                
            case .ImageTextInputViewGroups:
                let imageDataList = content.contents.map { ImageData(title:  $0.title, icon: $0.icon, identifier: $0.identifier)}
                let groups = ImageTextInputViewGroups(iconDataList: imageDataList)
                groups.identifier = content.identifier
                groups.title = content.title
                self.contentStackView.addArrangedSubview(groups)
                self.imageInputGroups = groups
                self.viewInfo[content.identifier] = groups
                
            case .ImageInputTextView:
                let imageInputViw = ImageInputTextView()
                imageInputViw.title = content.title
                if let icon = content.icon {
                    imageInputViw.icon = UIImage(named: icon)
                }
                imageInputViw.identifier = content.identifier
                self.contentStackView.addArrangedSubview(imageInputViw)
                imageInputViw.isAxisVetical = false
                self.viewInfo[content.identifier] = imageInputViw
                
            case .Footer:
                let button = Button()
                button.setTitle(content.title, for: .normal)
                self.footerParentView.addSubview(button, insets: UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16))
                button.addTarget(self, action: #selector(self.footerClick), for: .touchUpInside)
                self.nextButton = button
                self.footerTopConstraint?.isActive = true
                self.contentStackBottomConstraint?.isActive = false
                
            case .Button:
                let button = Button()
                button.setTitle(content.title, for: .normal)
                self.contentStackView.addArrangedSubview(button)
                self.viewInfo[content.identifier] = button
                
            case .UnderLineButton:
                let button = Button()
                button.style = .underline
                button.setTitle(content.title, for: .normal)
                self.contentStackView.addArrangedSubview(button)
                self.viewInfo[content.identifier] = button
                
            case .Label:
                let label = UILabel()
                label.textColor = content.textColorName == "red" ? UIColor.red : .black
                self.contentStackView.addArrangedSubview(label)
                label.text = content.title
                self.viewInfo[content.identifier] = label
                label.font = UIFont.body
                label.numberOfLines = 0
                
            case .Placeholder:
                guard let view = self.delegate?.placeholderView(forIdentifier: content.identifier) else {
                   continue
                }
                self.contentStackView.addArrangedSubview(view)
                
            default:
                continue
            }
        }
    }
    
    private func configureTextInputView(content: ContentData) {
        let ageInputView = TextInputView()
        ageInputView.title = content.title
        ageInputView.placeholder = content.description
        self.contentStackView.addArrangedSubview(ageInputView)
        ageInputView.underlineView.backgroundColor = Appearance.color
        ageInputView.keyboardType = .numberPad
        if content.identifier == "yourAge" {
            self.yourAgeInputTextView = ageInputView
        } else if content.identifier == "cigratesPerDay" {
            self.cigratesPerDayTextInputView = ageInputView
        } else if content.identifier == "ageOnCigrateStart" {
            self.ageOnCigrateStartTextInputView = ageInputView
        } else if "drinksInPast" == content.identifier {
            self.drinksIPastTextInputView = ageInputView
        }
        self.viewInfo[content.identifier] = ageInputView
    }
    
    @objc private func footerClick() {
        self.footerButtonPress?()
    }
    private func setup() {
        self.addSubview(self.contentStackView, insets: .zero, ignoreConstant: .bottom)
        self.addSubview(self.footerParentView, insets: .zero, ignoreConstant: .top)
        self.footerTopConstraint = self.footerParentView.topAnchor.constraint(greaterThanOrEqualTo: self.contentStackView.bottomAnchor, constant: 16.0)
        self.contentStackBottomConstraint = self.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 0)
        self.contentStackBottomConstraint?.isActive = true
        self.setupUIForDynamicContent()
    }
}
