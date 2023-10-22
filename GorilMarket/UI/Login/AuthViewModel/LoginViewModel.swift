//
//  LoginViewModel.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 21.10.2023.
//
import FirebaseAuth

// MARK: - LoginViewModelDelegate
protocol LoginViewModelDelegate {
    func didSignIn()
    func didFailToSignIn(error: Error)
    
    func didSignUp()
    func didFailToSignUp(error: Error)
}

class LoginViewModel {
    
    // MARK: - Properties
    private let auth: Auth
    var delegate: LoginViewModelDelegate?
    
    // MARK: - init
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    // MARK: - SignIn
    func signIn(email: String, password: String) {
        
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let e = error {
                self?.delegate?.didFailToSignIn(error: e)
            } else {
                self?.delegate?.didSignIn()
            }
        }
    }
    
    // MARK: - SignUP
    func signUp(email: String, password: String) {
        
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let e = error {
                print(e.localizedDescription)
                self?.delegate?.didFailToSignUp(error: e)
            } else {
                print("Kayit basarili")
                self?.delegate?.didSignUp()
            }
        }
    }
}
