//
//  TransactionDetailView.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class TransactionDetailView: UIView {
    
    lazy var transactionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
    }()
    
    lazy var accountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var amountLabel: UILabel = {
        let label = MainTitleLabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var directionLabel: UILabel = {
        let label = SubTitleLabel()
        return label
    }()
    
    var accountNumberView: AccounRowView = AccounRowView()
    var accountNameView: AccounRowView = AccounRowView()
    var bankCodeView: AccounRowView = AccounRowView()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separator
        return view
    }()
    
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(transactionOverview: TransactionOverview) {
        amountLabel.text = transactionOverview.amountInAccountCurrency.amountWithCurrency
        directionLabel.text = transactionOverview.direction.localizeString
        iconImageView.image = transactionOverview.direction.icon
    }
    
    func configureWith(detail: Transaction?) {
        guard let transactionDetail = detail else { return }
        
        accountNumberView.configureWith(title: LOC("transaction.detail.contra.account.number"), value: transactionDetail.contraAccount.accountNumber)
        accountNameView.configureWith(title: LOC("transaction.detail.contra.account.name"), value: transactionDetail.contraAccount.accountName)
        bankCodeView.configureWith(title: LOC("transaction.detail.contra.account.bank.code"), value: transactionDetail.contraAccount.bankCode)
    }
    
    func setupUI() {
        sv([
            transactionStackView,
            iconImageView,
            lineView,
            accountStackView
        ])

        Left == iconImageView.Left + UIConstat.viewPadding
        Top == transactionStackView.Top + UIConstat.viewPadding
        iconImageView.Right == transactionStackView.Left - 15
        Right == transactionStackView.Right - UIConstat.viewPadding
        Bottom == accountStackView.Bottom - UIConstat.viewPadding
        
        lineView.Top == iconImageView.Bottom + 15
        lineView.Left == transactionStackView.Left
        lineView.Right == transactionStackView.Right
        lineView.Height == 1
        
        iconImageView.Height == 30
        iconImageView.CenterY == transactionStackView.CenterY
        iconImageView.Height == iconImageView.Width
        
        accountStackView.Top == lineView.Bottom + UIConstat.cellPadding
        accountStackView.Left == transactionStackView.Left
        accountStackView.Right == transactionStackView.Right
        
        transactionStackView.addArrangedSubview(amountLabel)
        transactionStackView.addArrangedSubview(directionLabel)
        
        accountStackView.addArrangedSubview(accountNumberView)
        accountStackView.addArrangedSubview(accountNameView)
        accountStackView.addArrangedSubview(bankCodeView)
    }
}

class AccounRowView: UIView {
    
    lazy var titleLabel: UILabel = {
        return SecondaryLabel()
    }()
    
    lazy var valueLabel: UILabel = {
        return PrimaryLabel()
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI() {
        sv([stackView])
        
        stackView.Top == Top
        stackView.Bottom == Bottom
        stackView.Left == Left
        stackView.Right == Right
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    func configureWith(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
