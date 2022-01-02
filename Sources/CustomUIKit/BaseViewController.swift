//
//  File.swift
//  
//
//  Created by Jageloo Yadav on 02/01/22.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    
    public var backgroundImage = UIImageView()
    public let scrollingContentView = UIView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldEmbedInScrollView {
            let wrapperView = UIView()
            let scrollView = UIScrollView()
            wrapperView.backgroundColor = .clear
            self.view.addSubview(wrapperView)
            wrapperView.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
            scrollView.backgroundColor = .clear
            wrapperView.addSubview(scrollView)
            scrollView.anchorToSuperView()
            scrollingContentView.backgroundColor = .clear
            scrollView.addSubview(scrollingContentView)
            scrollingContentView.anchorToSuperView()
            scrollingContentView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor).isActive = true
            scrollingContentView.heightAnchor.constraint(greaterThanOrEqualTo: wrapperView.heightAnchor).isActive = true
        }
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open var shouldEmbedInScrollView: Bool {
        return true
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}


