//
//  UIConstants.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit

struct UIConstat {
    static let cellPadding: CGFloat = 8
    static let viewPadding: CGFloat = 15
}

func LOC(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
