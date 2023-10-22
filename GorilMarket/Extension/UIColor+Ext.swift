//
//  UIColor+Ext.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 12.10.2023.
//

import UIKit

extension UIColor {
    static var primaryColor: UIColor? {
        return UIColor(named: "PrimaryColor")
    }
    
    static var secondaryColor: UIColor? {
        return UIColor(named: "SecondaryColor")
    }
    
    static var thirdColor: UIColor? {
        return UIColor(named: "ThirdColor")
    }
    
    static var backgroundColor: UIColor? {
        return UIColor(named: "Background")
    }
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
          return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
      }
      
      static func colorFromHex(_ hex: String) -> UIColor {
          var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
          if hexString.hasPrefix("#") {
              hexString.remove(at: hexString.startIndex)
          }
          if hexString.count != 6 {
              return UIColor.magenta
          }
          
          var rgb: UInt64 = 0
          Scanner.init(string: hexString).scanHexInt64(&rgb)
          
          return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                              green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                              blue: CGFloat(rgb & 0x0000FF)/255,
                              alpha: 1.0)
      }
      
}
