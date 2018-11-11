//
//  UILabel+CustomLabel.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
    }
}

class MainTitleLabel: CustomLabel {
    override func setupUI() {
        font = UIFont.boltFont(size: 15)
        textColor = UIColor.primaryText
    }
}

class SubTitleLabel: CustomLabel {
    override func setupUI() {
        font = UIFont.regularFont(size: 13)
        textColor = UIColor.secondaryText
    }
}

class PrimaryLabel: CustomLabel {
    override func setupUI() {
        font = UIFont.boltFont(size: 13)
        textColor = UIColor.primaryText
    }
}

class SecondaryLabel: CustomLabel {
    override func setupUI() {
        font = UIFont.regularFont(size: 13)
        textColor = UIColor.secondaryText
    }
}
