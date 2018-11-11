//
//  TransactionEntity+Unbox.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import Unbox

extension Transaction: Unboxable {
    init(unboxer: Unboxer) throws {
        contraAccount = try unboxer.unbox(key: "contraAccount")
    }
}

