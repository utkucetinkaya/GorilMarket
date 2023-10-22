//
//  marketRepository.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 17.10.2023.
//

import Foundation

class MealsRepository {
    
    // MARK: - Properties
    let networkService = NetworkManager.shared
    static let shared = MealsRepository()
    
    // MARK: - Get All Meals
    func fetchAllMeals(completion: @escaping (Result<FoodResponse, Error>) -> Void) {
        
        networkService.request(.tumYemekleriGetir, type: FoodResponse.self) { result in
            switch result {
            case .success(let foodResponse):
                completion(.success(foodResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Past Add Meal Cart
    func addMealToCart(mealName: String, mealImageName: String, mealPrice: String, mealOrderQuantity: String, username: String, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        
        networkService.request(.sepeteYemekEkle(name: mealName, imageName: mealImageName, price: Int(mealPrice) ?? 0, order: Int(mealOrderQuantity) ?? 0, username: username), type: CartResponse.self) { result in
            switch result {
            case .success(let cartResponse):
                completion(.success(cartResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: - Get Cart Meals
    func fetchCartMeals(username: String, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        
        networkService.request(.sepettekiYemekleriGetir(username: username), type: CartResponse.self) { result in
            switch result {
            case .success(let cartResponse):
                completion(.success(cartResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
     
    // MARK: - Delete Meal From Cart
    func deleteMealFromCart(cartID: String, username: String, completion: @escaping (Result<CartResponse, Error>) -> Void) {
        
        networkService.request(.sepettenYemekSil(cartID: cartID, username: username), type: CartResponse.self) { result in
            switch result {
            case .success(let cartResponse):
                completion(.success(cartResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
