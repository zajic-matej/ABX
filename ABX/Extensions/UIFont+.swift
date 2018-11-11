//
//  UIFont+.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "KohinoorDevanagari-Regular", size: size)!
    }
    
    static func boltFont(size: CGFloat) -> UIFont {
        return UIFont(name: "KohinoorDevanagari-Semibold", size: size)!
    }
    
    static func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "KohinoorDevanagari-Light", size: size)!
    }
}
