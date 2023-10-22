//
//  CartViewModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 20.10.2023.
//

import Foundation

protocol FetchCartMealsResponseProtocol: AnyObject {
    func fetchCartSuccess(cart: [CartModel])
    func failFetchCart(error: String)
}

class CartViewModel {
    
    // MARK: - Properties
    var cartResponse: CartResponse?
    let repository = MealsRepository.shared
    weak var delegate: FetchCartMealsResponseProtocol?
    
    // MARK: - FetchCartMeals
    func fetchCartMeals(username: String) {
        repository.fetchCartMeals(username: username) { result in
            switch result {
            case .success(let cartResponse):
                if let delegate = self.delegate {
                    delegate.fetchCartSuccess(cart: cartResponse.cart ?? [])
                }
            case .failure(let error):
                self.delegate?.failFetchCart(error: error.localizedDescription)
            }
        }
    }
    
    // MARK: - DeleteMealFromCart
    func deleteMealFromCart(cartID: String, username: String) {
        repository.deleteMealFromCart(cartID: cartID, username: username) { result in
            switch result {
            case .success(let cartResponse):
                self.cartResponse = cartResponse
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
