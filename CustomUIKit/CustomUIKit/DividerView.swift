//
//  DividerView.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 11/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

class DividerView: ViewControl {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        self.backgroundColor = Color.appColour
    }
}
