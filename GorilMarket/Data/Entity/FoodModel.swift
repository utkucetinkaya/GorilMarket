//
//  FoodModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import Foundation

// MARK: - Food
struct Food: Codable {
    var id: String?
    var name:String?
    var imageName:String?
    var price: String?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case id = "yemek_id"
        case name = "yemek_adi"
        case imageName = "yemek_resim_adi"
        case price = "yemek_fiyat"
    }
}
