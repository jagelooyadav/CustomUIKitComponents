//
//  ViewController.swift
//  ComponentTestApp
//
//  Created by Jageloo Yadav on 02/01/22.
//

import UIKit
import CustomUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = Button(type: .custom)
        self.view.addSubview(button)
        button.setTitle("Custom button", for: .normal)
        button.customType = .plane
        button.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                 bottomRelation: .ignore,
                                 leading: 20.0,
                                 trailing: 20.0,
                                 top: 20.0)
        button.primaryColor = .blue
        button.customType  = .bordered
    }
}

