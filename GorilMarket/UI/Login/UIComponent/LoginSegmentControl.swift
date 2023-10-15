//
//  LoginSegmentControl.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 14.10.2023.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        setBorder(width: 1, color: UIColor.primaryColor ?? .clear)
        let segmentStringSelected: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        let segmentStringHighlited: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        setTitleTextAttributes(segmentStringHighlited, for: .normal)
        setTitleTextAttributes(segmentStringSelected, for: .selected)
        setTitleTextAttributes(segmentStringHighlited, for: .highlighted)
        
        layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = UIColor.secondaryColor ?? .clear
        } else {
            tintColor = UIColor.primaryColor ?? .clear
        }
        
        backgroundColor = UIColor.primaryColor ?? .clear
        
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        clipsToBounds = true
        
        setCorner(radius: 24)
        layer.maskedCorners = maskedCorners
        
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex),
           let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.image = UIImage()
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.backgroundColor = UIColor.secondaryColor ?? .clear
            
            foregroundImageView.layer.cornerRadius = bounds.height / 2 + 5
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
