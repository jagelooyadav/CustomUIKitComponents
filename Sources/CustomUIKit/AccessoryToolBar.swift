//
//  AccessoryToolBar.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 8/29/17.
//
//

import UIKit

public class AccessoryToolBar: UIToolbar {
    private static let horizontalSpacing: CGFloat = 37.0

    public var inputViews: [UIView]? {
        didSet {
            self.setUpToolBar()
        }
    }

    public var done: (() -> Void)?

     @objc public var activeView: UIView? {
        didSet {
            guard let inputViews = self.inputViews, inputViews.count > 1 else {
                return
            }
            
            switch self.activeView {
            case let first where first == inputViews.first:
                self.previousButton.isEnabled = false
                self.nextButton.isEnabled = true
                
            case let last where last == inputViews.last:
                self.previousButton.isEnabled = true
                self.nextButton.isEnabled = false
                
            default:
                self.previousButton.isEnabled = true
                self.nextButton.isEnabled = true
            }
        }
    }
    
    // MARK: Private
    
    lazy private var nextButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextButtonPressed))
    }()
    
    lazy private var previousButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Previous", style: .done, target: self, action: #selector(previousButtonPressed))
    }()
    
    lazy private var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonPressed))
        return doneButton
    }()
    

    private func addDoneButton() {
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.items = [flexButton, self.doneButton]
        self.sizeToFit()
    }
    
    private func addNextAndPreviousButton() {
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let fixButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        fixButton.width = type(of: self).horizontalSpacing

        self.items = [self.previousButton, fixButton, self.nextButton, flexButton, self.doneButton]
        self.sizeToFit()
    }
    
    private func activeViewIndex() -> Int? {
        guard let activeView = self.activeView else {
            return nil
        }
        return inputViews?.firstIndex(of: activeView)
    }
    
    private func setUpToolBar() {
        guard let inputViews = self.inputViews else { return }

        if inputViews.count > 1 {
            self.addNextAndPreviousButton()
        } else {
            self.addDoneButton()
        }
    }
    
    @objc convenience init(inputViews: [UIView]) {
        self.init()
        
        self.inputViews = inputViews
        self.setUpToolBar()
    }
    
    @objc private func doneButtonPressed() {
        self.activeView?.resignFirstResponder()
        self.done?()
    }
    
    @objc private func nextButtonPressed() {
        guard let inputViews = self.inputViews,
            let currentIndex = self.activeViewIndex(),
            currentIndex + 1 < inputViews.count else {
                return
        }
        
        let nextInputView = inputViews[currentIndex + 1]
        nextInputView.becomeFirstResponder()
    }
    
    @objc private func previousButtonPressed() {
        guard let inputViews = self.inputViews,
            let currentIndex = self.activeViewIndex(),
            currentIndex > 0 else {
                return
        }
        
        let previousInputView = inputViews[currentIndex - 1]
        previousInputView.becomeFirstResponder()
    }
}
