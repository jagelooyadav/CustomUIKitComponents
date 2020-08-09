//
//  ModalView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 08/08/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit

public protocol ModalInfo {
    var backgrondImage: UIImage? { get }
    var containerBorderWidth: CGFloat { get }
    var containerBorderColor: UIColor { get }
    var containerBackgroundColour: UIColor { get }
    var contentView: UIView? { get }
    var coverColor: UIColor { get }
    var coverAlpha: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var modalTitle: String? { get }
    func pageRendered()
}

public extension ModalInfo {
    
    var backgrondImage: UIImage? { return nil  }
    var containerBorderWidth: CGFloat { return 2.0 }
    var containerBackgroundColour: UIColor { return .white }
    var contentView: UIView? { return nil }
    var coverColor: UIColor { return .white }
    var coverAlpha: CGFloat { return 0.7 }
    var containerBorderColor: UIColor { return .red }
    var cornerRadius: CGFloat { return 40.0 }
    var modalTitle: String? { return "Evaluating your device" }
    func pageRendered() {}
}



public class ModalView: UIView {
    
    private let modelInfo: ModalInfo
    
    private var containerView = UIView()
    
    private var contentHolder = UIView()
    
    private var transparentView = UIControl()
    
    private var modalTitleLabel = UILabel()
    
    public init(modelInfo info: ModalInfo) {
        self.modelInfo = info
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var backgroundImage = UIImageView()
    
    public func setup() {
        self.addSubview(self.backgroundImage, insets: .zero, ignoreConstant: .bottom)
        self.addSubview(self.modalTitleLabel,
                        insets: UIEdgeInsets(top: 25,
                                             left: 16,
                                             bottom: 16,
                                             right: 16),
                        ignoreConstant: .bottom)
        self.modalTitleLabel.textColor = .white
        self.modalTitleLabel.text = self.modelInfo.modalTitle
        self.modalTitleLabel.textAlignment = .center
        self.modalTitleLabel.numberOfLines = 0
        self.backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65, constant: 0.0).isActive = true
        if let image = self.modelInfo.backgrondImage {
            self.backgroundImage.image = image
        } else {
            self.backgroundImage.image = UIImage(named: "background_ocean")
        }
        self.backgroundImage.contentMode = .scaleToFill
        self.containerView.backgroundColor = .clear
        self.backgroundColor = self.modelInfo.coverColor
        self.addSubview(transparentView, insets: .zero)
        transparentView.alpha = self.modelInfo.coverAlpha
        transparentView.backgroundColor = UIColor(actualRed: 88.0, green: 57.0, blue: 131.0)
        self.addContentView()
        transparentView.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        transparentView.isUserInteractionEnabled = true
        transparentView.isEnabled = true
    }
    
    private func addContentView() {
        self.containerView.backgroundColor = .clear
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(self.contentHolder, insets: UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
        self.contentHolder.layer.borderWidth = self.modelInfo.containerBorderWidth
        self.contentHolder.layer.borderColor = self.modelInfo.containerBorderColor.cgColor
        self.contentHolder.backgroundColor = self.modelInfo.containerBackgroundColour
        self.contentHolder.layer.cornerRadius = self.modelInfo.cornerRadius
        
        if let contentView = self.modelInfo.contentView {
            self.contentHolder.addSubview(contentView, insets: UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
        }
    }
    
    public func show(inView view: UIView? = UIApplication.shared.keyWindow,
                     topMargin: CGFloat = 60.0,
                     bottomMargin: CGFloat = 20.0) {
        guard let superView = view else { return }
        superView.addSubview(self, insets: .zero)
        
        superView.addSubview(self.containerView)
        /// adding constraint
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            superView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.containerView.topAnchor.constraint(equalTo: superView.topAnchor,constant: topMargin),
            superView.bottomAnchor.constraint(greaterThanOrEqualTo: self.containerView.bottomAnchor, constant: bottomMargin)
        ])
        executeAfter(0.1) {
            self.modelInfo.pageRendered()
        }
    }
    
    @objc public func dismiss() {
        self.removeFromSuperview()
        self.containerView.removeFromSuperview()
    }
}
