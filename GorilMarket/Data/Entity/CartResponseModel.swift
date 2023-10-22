//
//  CartResponseModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import Foundation

// MARK: - CartResponseModel
struct CartResponse: Codable {
    
    var cart: [CartModel]?
    var success: Int?
    var message: String?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case cart = "sepet_yemekler"
        case success, message
    }
}
