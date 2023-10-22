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
}
