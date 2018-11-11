//
//  TransactionOverviewCell.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class TransactionOverviewCell: UITableViewCell {
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    lazy var amountLabel: UILabel = {
        let label = MainTitleLabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var directionLabel: UILabel = {
        let label = SubTitleLabel()
        label.numberOfLines = 0
        return label
    }()
    
    let iconImageView = UIImageView()
    
    lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "rightArrow")
        return imageView
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
            labelStackView,
            iconImageView,
            rightArrowImageView
        ])
        
        contentView.Left == iconImageView.Left + UIConstat.cellPadding
        contentView.Top == labelStackView.Top + UIConstat.cellPadding
        contentView.Bottom == labelStackView.Bottom - UIConstat.cellPadding
        iconImageView.Right == labelStackView.Left - 15
        contentView.Right == labelStackView.Right - UIConstat.cellPadding
        
        iconImageView.Height == 30
        iconImageView.CenterY == contentView.CenterY
        iconImageView.Height == iconImageView.Width
        
        rightArrowImageView.Right == contentView.Right - UIConstat.cellPadding
        rightArrowImageView.CenterY == contentView.CenterY
        rightArrowImageView.Height == 17
        rightArrowImageView.Width == 9
        
        labelStackView.addArrangedSubview(amountLabel)
        labelStackView.addArrangedSubview(directionLabel)
    }
    
    func configureWith(transaction: TransactionOverview) {
        amountLabel.text = transaction.amountInAccountCurrency.amountWithCurrency
        directionLabel.text = transaction.direction.localizeString
        iconImageView.image = transaction.direction.icon
    }
}
