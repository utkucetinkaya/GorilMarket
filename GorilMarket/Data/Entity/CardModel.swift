//
//  CardModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import Foundation

// MARK: - CartModel
struct CartModel: Codable {
    var cartID: String?
    var name: String?
    var imageName: String?
    var price: String?
    var order: String?
    var username: String?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case cartID = "sepet_yemek_id"
        case name = "yemek_adi"
        case imageName = "yemek_resim_adi"
        case price = "yemek_fiyat"
        case order = "yemek_siparis_adet"
        case username = "kullanici_adi"
    }
}
