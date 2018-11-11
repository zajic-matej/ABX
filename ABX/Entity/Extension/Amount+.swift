//
//  Amount+.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation

extension Amount {
    var amountWithCurrency: String {
        return "\(fomrattedAmount) \(currency)"
    }
    
    private var fomrattedAmount: String {
        return String(format: "%.0f", amount)
    }
}
