//
//  Transaction+Unbox.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import Unbox

extension TransactionOverview: Unboxable {
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        // I dont know where is the information about currency
        amountInAccountCurrency = Amount(amount: try unboxer.unbox(key: "amountInAccountCurrency"), currency: "CZK")
        direction = try unboxer.unbox(key: "direction")
    }
}
