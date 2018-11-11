//
//  AccountEntity+Unbox.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import Unbox

extension Account: Unboxable {
    init(unboxer: Unboxer) throws {
        accountNumber = try unboxer.unbox(key: "accountNumber")
        accountName = try unboxer.unbox(key: "accountName")
        bankCode = try unboxer.unbox(key: "bankCode")
    }
}
