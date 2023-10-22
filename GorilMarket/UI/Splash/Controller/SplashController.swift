//
//  SplashController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 9.10.2023.
//

import UIKit

class SplashController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var gorilLabel: UILabel!
    @IBOutlet weak private var marketLabel: UILabel!
    @IBOutlet weak private var backgroundView: UIView!
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setAnimated()
        goToOnboardingScreen()
    }
    
    // MARK: - Functions
    private func setAnimated() {
         
           logoImageView.alpha = 0
           gorilLabel.alpha = 0
           marketLabel.alpha = 0
           backgroundView.alpha = 0
           
           UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut) {
               self.backgroundView.alpha = 1
           } completion: { _ in
               
               self.showGorilLabel()
           }
       }
       
       private func showGorilLabel() {
           UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut) {
               self.gorilLabel.alpha = 1
           } completion: { _ in
               
               self.showMarketLabel()
           }
       }
       
       private func showMarketLabel() {
           UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
               self.marketLabel.alpha = 1
           } completion: { _ in
    
               self.showLogoImageView()
           }
       }
       
       private func showLogoImageView() {
           UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
               self.logoImageView.alpha = 1
           }
       }
   
    private func goToOnboardingScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc = OnboardingController()
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}
