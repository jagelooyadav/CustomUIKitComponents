//
//  Button.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

/**
 Styled button component  with progress bar functionality
 */

public class ProgressBarButton: Button {
    private let progressBar = UIButton()
    private var heightConstraint: NSLayoutConstraint?
    private var progressBarWidth: NSLayoutConstraint?
    
    /// Sets progress value label
    public var progressValueLabel: String = "" {
        didSet {
            self.title = self.progressValueLabel
        }
    }
    
    /// Progress bar progress in percentage value from 0.0-1.0
    public var progress: CGFloat = 0.0 {
        didSet {
            self.progressBar.backgroundColor = self.primaryColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.progressBarWidth?.constant = self.frame.width * self.progress
            }
            if progress > 0 {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            } else {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
            }
        }
    }
    
    /// Button title
    public var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.heightConstraint?.isActive = true
        self.titleLabel?.numberOfLines = 0
        self.addSubview(progressBar)
        self.progressBarWidth = self.progressBar.widthAnchor.constraint(equalToConstant: 0.0)
        self.progressBarWidth?.constant = 0
        self.progressBar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        progressBar.anchorToSuperView(trailingRelation: .ignore)
        self.clipsToBounds = true
        self.progressBarWidth?.isActive = true
        self.progressBar.backgroundColor = primaryColor
        self.bringSubviewToFront(self.titleLabel!)
        self.progressBar.isUserInteractionEnabled = false
    }
    
    public convenience override init() {
        self.init(frame: .zero)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.progressBar.layer.cornerRadius = self.progressBar.frame.height/2
    }
}
