//
//  UIView+Ext.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 9.10.2023.
//

import UIKit

extension UIView {
    
    // MARK: - CornerRadius
    func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    // MARK: - Border
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    // MARK: - TabBarShadow
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.masksToBounds = false
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(red: 174/255, green: 174/255, blue: 192/255, alpha: 0.4).cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 1)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                 y: bounds.maxY - layer.shadowRadius,
                                                 width: bounds.width,
                                                 height: layer.shadowRadius)).cgPath
    
    }
    
    // MARK: - BackgroundView
    func addGradientBackground(colors: [UIColor]) {
         // Create a gradient layer
         let gradientLayer = CAGradientLayer()
         // Set the frame of the layer to match the view's frame
         gradientLayer.frame = self.bounds
         // Set the colors of the layer to match the colors parameter
         // Use map to convert UIColor to CGColor
         gradientLayer.colors = colors.map { $0.cgColor }
         // Insert the layer at the bottom of the view's layer hierarchy
         self.layer.insertSublayer(gradientLayer, at: 0)
     }
}
