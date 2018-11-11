//
//  Transaction.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation

struct TransactionOverview {
    let id: Int
    let amountInAccountCurrency: Amount
    let direction: TransactionDirection
}
