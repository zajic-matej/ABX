//
//  UITableView+.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    public func registerCell<T: UITableViewCell>(_ cell : T.Type) {
        register(cell, forCellReuseIdentifier: NSStringFromClass(cell))
    }
    
    public func dequeueCell<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: NSStringFromClass(cell), for: indexPath) as? T
    }
}
