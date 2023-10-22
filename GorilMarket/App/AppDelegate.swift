//
//  AppDelegate.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 8.10.2023.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let splashViewController = SplashController()
        let navigationController = UINavigationController(rootViewController: splashViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        navigationController.navigationBar.isHidden = true
        UITabBar.appearance().backgroundColor = .backgroundColor
        FirebaseApp.configure()
        return true
    }
}
