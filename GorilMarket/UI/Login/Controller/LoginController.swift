//
//  LoginController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 12.10.2023.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak private var segmentOutlet: SegmentedControl!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: PassWordTextField!
    @IBOutlet weak private var nameImage: UIImageView!
    @IBOutlet weak private var emailImage: UIImageView!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var passwordImage: UIImageView!
    
    // MARK: - PageTypeEnum
    
    private enum PageType {
        case login
        case signUp
    }
    
    // MARK: - Properties
    private var currentPageType: PageType = .login {
        didSet {
            setupViewsFor(pageType: currentPageType)
        }
    }
    
    let loginViewModel = LoginViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setupViewsFor(pageType: .login)
        loginViewModel.delegate = self
    }
    
    // MARK: - Set UI
    private func setUI() {
        
        nameTextField.setCorner(radius: 24)
        nameTextField.setBorder(width: 1, color: UIColor.black)
        
        emailTextField.setCorner(radius: 24)
        emailTextField.setBorder(width: 2, color: UIColor.black)
        
        passwordTextField.setCorner(radius: 24)
        passwordTextField.setBorder(width: 2, color: UIColor.black)
        
        loginButton.setCorner(radius: 20)
        loginButton.setBorder(width: 1, color: UIColor.primaryColor ?? .clear)
        
        signUpButton.setCorner(radius: 20)
        signUpButton.setBorder(width: 1, color: UIColor.white)
        
    }
    
    // MARK: - Set PageType
    private func setupViewsFor(pageType: PageType) {
        nameTextField.isHidden = pageType == .signUp
        signUpButton.isHidden = pageType == .signUp
        loginButton.isHidden = pageType == .login
        nameImage.isHidden = pageType == .signUp
    }
    
    // MARK: - SegmentAction
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
    
    // MARK: - LoginAction
    @IBAction func loginClicked(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            loginViewModel.signIn(email: email, password: password)
        }
    }
    
    // MARK: - SignInAction
    @IBAction func signUpClicked(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            loginViewModel.signUp(email: email, password: password)
        }
    }
}

// MARK: - LoginViewModelDelegate
extension LoginController: LoginViewModelDelegate {
  
    // MARK: - sign up
    func didSignUp() {
        self.showPopUp(title: "Kayıt olma başarılı", text: "Hesabınız başarıyla oluşturuldu.", buttontext: "Tamam")
    }
    
    func didFailToSignUp(error: Error) {
        var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(title: "Kayıt olma hatası", text: "\(error.localizedDescription)", buttontext: "Tamam")
        self.present(popUpWindow, animated: true, completion: nil)

    }
    
    // MARK: - sign in
    func didSignIn() {
        self.showPopUp(title: "Giriş yapma başarılı ✔", text: "Goril Markete Hoşgeldin 👋", buttontext: "Hoşbuldum")

        let vc = TabBarController()
        self.navigationController?.setViewControllers([vc], animated: true)
        print("Giris basarili")
    }
    
    func didFailToSignIn(error: Error) {
        self.showPopUp(title: "Giriş yapma hatası", text: "\(error.localizedDescription)", buttontext: "Tamam")
    }
}
