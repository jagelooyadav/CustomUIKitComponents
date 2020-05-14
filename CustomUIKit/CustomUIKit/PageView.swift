//
//  PageView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 11/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

class PageView: ViewControl {
    
    var expectationBox: RoundedInformationBox?
    var sexGroups: ImageGroupButtons?
    var yourAgeInputTextView: TextInputView?
    var nextButton: Button?
    var smokingQuestionView: ObjectiveQestionView?
    var didYouSmokeInPastQuestionView: ObjectiveQestionView?
    var cigratesPerDayTextInputView: TextInputView?
    var ageOnCigrateStartTextInputView: TextInputView?
    var alchohalOptionsQuestionView: ObjectiveQestionView?
    var drinksIPastTextInputView: TextInputView?
    var imageInputGroups: ImageTextInputViewGroups?
    
    @objc var footerButtonPress: (() -> Void)?
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }()
    
    var footerParentView = UIView()
    
    private let content: ContentData
    
    init(content: ContentData) {
        self.content = content
        super.init(frame: .zero)
        self.setup()
    }
    
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
                
            case .HeadingWithSeperator:
                let heding = HeadingWithSeperator(withString: content.title)
                self.contentStackView.addArrangedSubview(heding)
                
            case .ImageGroupButtons:
                let groups = ImageGroupButtons(images: content.images, names: content.names)
                self.contentStackView.addArrangedSubview(groups)
                self.sexGroups = groups
                
            case .TextInputView:
                self.configureTextInputView(content: content)
                
            case .ObjectiveQestionView:
                let question = Question(title: content.title, options: content.contents.map { $0.title })
                let questionsView = ObjectiveQestionView.init(question: question)
                self.contentStackView.addArrangedSubview(questionsView)
                if content.identifier == "smokingOption" {
                    self.smokingQuestionView = questionsView
                } else if content.identifier == "didYouSmokeDaily" {
                    self.didYouSmokeInPastQuestionView = questionsView
                } else if "alchohalOption" == content.identifier {
                    self.alchohalOptionsQuestionView = questionsView
                }
                
            case .ImageTextInputViewGroups:
                let imageDataList = content.contents.map { ImageData(title:  $0.title, icon: $0.icon, identifier: $0.identifier)}
                let groups = ImageTextInputViewGroups(iconDataList: imageDataList)
                groups.identifier = content.identifier
                groups.title = content.title
                self.contentStackView.addArrangedSubview(groups)
                self.imageInputGroups = groups
                
            case .ImageInputTextView:
                let imageInputViw = ImageInputTextView()
                imageInputViw.title = content.title
                if let icon = content.icon {
                    imageInputViw.icon = UIImage(named: icon)
                }
                imageInputViw.identifier = content.identifier
                self.contentStackView.addArrangedSubview(imageInputViw)
                imageInputViw.isAxisVetical = false
                
            case .Footer:
                let button = Button()
                button.setTitle(content.title, for: .normal)
                self.footerParentView.addSubview(button, insets: UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16))
                button.addTarget(self, action: #selector(self.footerClick), for: .touchUpInside)
                self.nextButton = button
                
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
        ageInputView.underlineView.backgroundColor = Color.appColour
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
    }
    
    @objc private func footerClick() {
        self.footerButtonPress?()
    }
    private func setup() {
        self.addSubview(self.contentStackView, insets: .zero, ignoreConstant: .bottom)
        self.addSubview(self.footerParentView, insets: .zero, ignoreConstant: .top)
        self.footerParentView.topAnchor.constraint(greaterThanOrEqualTo: self.contentStackView.bottomAnchor, constant: 16.0).isActive = true
        self.setupUIForDynamicContent()
    }
}
