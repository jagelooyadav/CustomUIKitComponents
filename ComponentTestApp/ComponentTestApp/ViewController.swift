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
        
        /// Add buttons components
        
        let label = UILabel()
        label.text = "Button"
        label.font = UIFont.bigBrother
    
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(createButton(type: .bordered, color: .blue))
        stack.addArrangedSubview(createButton(type: .plane, color: .blue))
        
        stack.addArrangedSubview(createButton(type: .bordered, color: Color.darkRed))
        stack.addArrangedSubview(createButton(type: .plane, color: Color.darkRed))
        
        stack.addArrangedSubview(createButton(type: .bordered, color: .green))
        stack.addArrangedSubview(createButton(type: .plane, color: .green))
        
        //Add button code sample label
        stack.addArrangedSubview(createSampleCodeView(self.createButtonHTML()))
        
        stack.addArrangedSubview(createPlaceholder(title: "ProgressBarButton"))
        stack.addArrangedSubview(createProgressButton())
        stack.addArrangedSubview(createSampleCodeView(createProgressBarButtonHTML()))
        
        /// Red
        stack.addArrangedSubview(createPlaceholder(title: "Question View - Blue"))
        let question2 = Question(title: "Why should you use custom ui component instead making fresh every time?",
                                                                        options: ["It will decrease code lines in project",
                                                                                  "It will reduce time in development",
                                                                                  "It increase time in development",
                                                                                  "It will reduce time in development"])
        let questionView2 = ObjectiveQestionView(question: question2)
        questionView2.questionTintColor = .red
        questionView2.isMultipleSelection = true
        stack.addArrangedSubview(questionView2)
        
        
        /// green
        stack.addArrangedSubview(createPlaceholder(title: "Question View - Green"))
        let question3 = Question(title: "Why should you use custom ui component instead making fresh every time?",
                                                                        options: ["It will decrease code",
                                                                                  "It will reduce time",
                                                                                  "It increase time in development",
                                                                                  "It will reduce time in development"])
        let questionView3 = ObjectiveQestionView(question: question3)
        questionView3.questionTintColor = .lightGray
        questionView3.isMultipleSelection = true
        stack.addArrangedSubview(questionView3)
        stack.addArrangedSubview(createSampleCodeView(createQuestionViewHTML()))
    }
    
    override var shouldEmbedInScrollView: Bool {
        return true
    }
    
    func createButton(type: Button.ButtonType, color: UIColor) -> Button {
        let button = Button()
        button.customType = type
        button.primaryColor = color
        let title = type == .bordered ? "Bordered button" : "Plane Button"
        button.setTitle(title, for: .normal)
        return button
    }
    
    func createPlaceholder(title: String) -> UIView {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.font = UIFont.bigBrother
        return label
    }
    
    func createSampleCodeView(_ html: String) -> UIView {
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
    
    func createProgressButton() -> UIView {
        let button = ProgressBarButton()
        button.primaryColor = .red
        button.progressValueLabel = "Progress: 70 %"
        button.progress = 0.70
        return button
    }
    
    func createButtonHTML() -> String {
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
        return html
    }
    
    func createProgressBarButtonHTML() -> String {
        let html = """
        <p style = "margin-left: 40px; background-color:clear;font-size: 20px">
            let button = ProgressBarButton()<BR>
            button.primaryColor = .red<BR>
            button.progressValueLabel = "Progress: 70 %"<BR>
            button.progress = 0.70
        </p>
        """
        return html
    }
    
    func createQuestionViewHTML() -> String {
        let html = """
        <p style = "margin-left: 40px; background-color:clear;font-size: 20px">
        <i>
            let question = Question(title: "Why should you use custom ui component instead making fresh every time?",
                                                                            options: ["It will decrease code lines in project",
                                                                                      "It will reduce time in development",
                                                                                      "It increase time in development",
                                                                                      "It will reduce time in development"])<BR>
            let questionView = ObjectiveQestionView(question: question)<BR>
            questionView.questionTintColor = .blue<BR>
            questionView.isMultipleSelection = true
        </i>
        </p>
        """
        return html
    }
}

