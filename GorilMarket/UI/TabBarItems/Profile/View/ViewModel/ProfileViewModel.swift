//
//  UserViewModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 19.10.2023.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {
    
    // MARK: - Properties
    static let shared = ProfileViewModel()
    
    // MARK: - Functions
    func logOut(completion: @escaping (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completion(false)
        }
    }
}
