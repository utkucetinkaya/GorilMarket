//
//  DetailViewModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 20.10.2023.
//

import UIKit
import Alamofire

class DetailViewModel {
    
    // MARK: - Properties
    var cartResponse: CartResponse?
    let repository = MealsRepository.shared
    
    // MARK: - AddMealToCart
    func addMealToCart(mealName: String, mealImageName: String, mealPrice: String, mealOrderQuantity: String, username: String, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        repository.addMealToCart(mealName: mealName, mealImageName: mealImageName, mealPrice: mealPrice, mealOrderQuantity: mealOrderQuantity, username: username) { result in
            completion(result)
        }
    }
}
