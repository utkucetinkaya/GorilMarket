//
//  UIViewController+Ext.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 22.10.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Show Alert
    func showAlert(title: String, message: String, style: UIAlertController.Style = .alert, actions: [UIAlertAction] = [UIAlertAction(title: "Tamam", style: .default, handler: nil)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Show Pop Up
    func showPopUp(title: String, text: String, buttontext: String) {
        let popUpWindow = PopUpWindow(title: title, text: text, buttontext: buttontext)
        self.present(popUpWindow, animated: true, completion: nil)
    }
    
    // MARK: - Show Toast
    func showToast(message: String, duration: TimeInterval = 2.5) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 15
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: toastLabel, attribute: .centerX, relatedBy: .equal, toItem: toastContainer, attribute: .centerX, multiplier: 1, constant: 0)
        let lableBottom = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -10)
        let labelTop = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 10)
        let labelLeading = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 10)
        let labelTrailing = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -10)
        
        let containerCenterX = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let containerTop = NSLayoutConstraint(item: toastContainer, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 30)
        let containerLeading = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self.view, attribute: .leading, multiplier: 1, constant: 50)
        let containerTrailing = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -50)
        
        self.view.addConstraints([centerX, lableBottom, labelTop, labelLeading, labelTrailing, containerCenterX, containerTop, containerLeading, containerTrailing])
        
        UIView.animate(withDuration: 0.5, animations: {
            toastContainer.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }) { _ in
                toastContainer.removeFromSuperview()
            }
        }
    }
}
