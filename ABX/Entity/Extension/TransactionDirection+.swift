//
//  TransactionDirection+.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit

extension TransactionDirection {
    var localizeString: String {
        switch self {
        case .INCOMING:
            return LOC("transaction.incoming")
        case .OUTGOING:
            return LOC("transaction.outgoing")
        }
    }
    
    var icon: UIImage {
        switch self {
        case .INCOMING:
            return #imageLiteral(resourceName: "incomingTransaction")
        case .OUTGOING:
            return #imageLiteral(resourceName: "outgoingTransaction")
        }
    }
}
