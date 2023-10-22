//
//  HTTPMethod.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 14.10.2023.
//

import Foundation
import UIKit
import FirebaseAuth

// MARK: - HTTP Methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

// MARK: - Constants
class Constants {
    static let shared = Constants()
    
    let baseURL = "http://kasimadalan.pe.hu/yemekler"
    let imageURL = "http://kasimadalan.pe.hu/yemekler/resimler/"
    let username = Auth.auth().currentUser?.email
}
