//
//  MealsViewModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 17.10.2023.
//

import UIKit

// MARK: - MealsResponseProtocol
protocol MealsResponseProtocol: AnyObject {
    func mealsFetchSuccess(meals: [Food])
}

class MealsViewModel {
    
    // MARK: - Properties
    weak var delegate: MealsResponseProtocol?
    let repository = MealsRepository.shared
    
    // MARK: - Fetch All Meals
    func fetchAllMeals() {
        repository.fetchAllMeals { [weak self] (result: Result<FoodResponse, Error>) in
            switch result {
            case .success(let meals):
                if let delegate = self?.delegate {
                    delegate.mealsFetchSuccess(meals: meals.foods ?? [])
                }
            case.failure(let error):
                debugPrint(error)
            }
        }
    }
}
