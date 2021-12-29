//
//  ContainerView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav : Group Centre on 26/11/2019.
//  Copyright © 2019 Jageloo Yadav : Group Centre. All rights reserved.
//

import UIKit

public class ProgresssHud: UIView {
    public var completion: (() -> Void)?
    
    lazy var backgroundView: UIView =  { vv in
        vv.backgroundColor = .black
        vv.alpha = 0.3
        return vv
    }(UIView())
    
    lazy var label = UILabel()
    
    lazy var activity = UIActivityIndicatorView.init(style: .large)
    
    lazy var activityView: UIView =  { vv in
        vv.backgroundColor = .white
        let sss = UIStackView()
        sss.axis = .vertical
        sss.addArrangedSubview(self.label)
        self.activity.startAnimating()
        self.activity.color = Appearance.color
        sss.addArrangedSubview(self.activity)
        
        vv.addSubview(sss, insets: UIEdgeInsets(top: 16.0, left: 10.0, bottom: 30.0, right: 16.0))
        
        return vv
    }(UIView())
    
    public func showInView(_ view: UIView = UIApplication.shared.keyWindow ?? UIView(), text: String = "Please wait...", delay: TimeInterval = 1.0, completion: (() -> Void)?) {
        self.completion = completion
        self.label.text = text
        self.label.textColor = self.appearanceColor
        self.label.textAlignment = .center
        view.addSubview(backgroundView, insets: .zero)
        view.addSubview(self.activityView)
        self.activityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor), self.activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        self.activityView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        self.activityView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        self.activityView.layer.cornerRadius = 15.0
        self.perform(#selector(self.hide), with: nil, afterDelay: delay)
    }
    
    public var appearanceColor: UIColor {
        get {
            return self.label.textColor
        }
        
        set {
            self.label.textColor = newValue
            self.activityView.tintColor = newValue
            self.activity.color = newValue
        }
    }
    
    @objc public func hide() {
        self.activityView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
        self.completion?()
    }
}

public class ContainerView: UIView, ShadowProvider {
    let container = UIView()
    
    public var containerView: UIView! {
        return self
    }
    
    public var shouldAddShadow: Bool = false {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUp()
    }
    
    private func setUp() {
        self.addSubview(container)
        container.anchorToSuperView(leading: 16, trailing: 16, top: 16, bottom: 16)
        container.backgroundColor = .white
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.cornerRadius = 10.0
        if shouldAddShadow {
            self.dropShadow()
        }
    }
}
