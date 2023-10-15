//
//  LoginController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 12.10.2023.
//

import UIKit

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
    @IBOutlet weak private var googleButton: UIButton!
    
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setupViewsFor(pageType: .login)
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
        signUpButton.setBorder(width: 2, color: UIColor.thirdColor ?? .clear)
        
        googleButton.setCorner(radius: 20)
        googleButton.setBorder(width: 1, color: UIColor.primaryColor ?? .clear)
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
}
