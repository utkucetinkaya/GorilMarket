//
//  NSObject+Ext.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 12.10.2023.
//

import Foundation

// MARK: - Name Of Class
extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
