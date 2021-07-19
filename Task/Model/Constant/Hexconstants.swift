//
//  Hexconstants.swift
//  Task
//
//  Created by Sagar Upadhyay on 19/07/21.
//

import UIKit
struct hexColorConstants {
    
    static let Long                                         = "00ff00"
    static let Short                                        = "ff0000"
    static let LongU                                        = "fff000"
    static let ShortC                                       = "ffff00"
    
}
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

