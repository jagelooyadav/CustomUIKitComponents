//
//  KeyboardHandler.swift
//  PhoneEstimator
//
//  Created by Jageloo Yadav on 04/04/22.
//  Copyright © 2022 Jageloo. All rights reserved.
//

import Foundation
import UIKit

public protocol KeyboardHandler: AnyObject {
    var scrollView: UIScrollView? { get }
    var keyboardUtility: KeyBoardUtility? { get set }
    func observeKeyboard()
    func clean()
}

public extension KeyboardHandler {
    func observeKeyboard() {
        keyboardUtility = KeyBoardUtility()
        keyboardUtility?.addObservers(scrollView)
    }
    
    func clean() {
        keyboardUtility?.clean()
    }
}

public class KeyBoardUtility {
    private var scrollView: UIScrollView?
    
    func addObservers(_ scrollView: UIScrollView?) {
        self.clean()
        self.scrollView = scrollView
        let notificationCentre = NotificationCenter.default
        notificationCentre.addObserver(self, selector: #selector(self.showKeyBoard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(self.hideBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func clean() {
        self.scrollView = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func showKeyBoard(notification: NSNotification) {
        guard let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboard, right: 0.0)
        self.scrollView?.contentInset = contentInset
    }
    
    @objc private func hideBoard() {
        self.scrollView?.contentInset = .zero
    }
    
    deinit {
        clean()
    }
}

