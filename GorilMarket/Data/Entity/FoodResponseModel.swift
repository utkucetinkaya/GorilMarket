//
//  FoodResponse.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 20.10.2023.
//

import Foundation

// MARK: - FoodResponseModel
struct FoodResponse: Codable {
    var foods: [Food]?
    var success: Int?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case foods = "yemekler"
    }
}
