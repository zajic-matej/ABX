//
//  TransactionFilterCell.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class TransactionFilterCell: UITableViewCell {
    
    lazy var filterLabel: UILabel = {
        let label = MainTitleLabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func render() {
        sv([
            filterLabel
        ])
        
        contentView.Left == filterLabel.Left + UIConstat.viewPadding
        contentView.Right == filterLabel.Right - UIConstat.viewPadding
        contentView.Top == filterLabel.Top + UIConstat.viewPadding
        contentView.Bottom == filterLabel.Bottom - UIConstat.viewPadding
        contentView.CenterY == filterLabel.CenterY
    }
    
    func configureWith(filter: Filter) {
        filterLabel.text = filter.name
    }
}
