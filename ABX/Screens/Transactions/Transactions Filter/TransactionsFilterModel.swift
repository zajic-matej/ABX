//
//  TransactionsFilterModel.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import RxSwift

protocol TransactionsFilterModel {
    var filters: [Filter] { get }
}

class TransactionsFilterModelImpl: TransactionsFilterModel {
    var filters: [Filter] {
        return [
            Filter(name: LOC("filter.outgoing"), direction: .OUTGOING),
            Filter(name: LOC("filter.incoming"), direction: .INCOMING),
            Filter(name: LOC("filter.all"), direction: nil)
        ]
    }
}
