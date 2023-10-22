//
//  TabBarController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import UIKit



final class TabBarController: UITabBarController {

    // MARK: - Properties

    let tabBarItems = [
        TabBarItem(viewController: HomeController(), icon: UIImage(named: "home"), title: "Ana Sayfa"),
        TabBarItem(viewController: CartController(), icon: UIImage(named: "shopping_bag"), title: "Sepetim"),
        TabBarItem(viewController: ProfileController(), icon: UIImage(named: "profile"), title: "Profil")
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        setupTabBarItems()

    }

    // MARK: - SetupTabBarItems
    private func setupTabBarItems() {

        var navControllers = [UINavigationController]()

        for item in tabBarItems {
            let nav = UINavigationController(rootViewController: item.viewController)
            nav.tabBarItem.title = item.title
            nav.tabBarItem.image = item.icon?.withRenderingMode(.alwaysTemplate)

            if let font = UIFont(name: "Poppins-Regular", size: 10) {
                nav.tabBarItem.setTitleTextAttributes([.font: font], for: .normal)
            }
            navControllers.append(nav)
        }

        self.setViewControllers(navControllers, animated: true)

    }

    // MARK: - Layoutcycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutTabBar()
        setupTabBar()
    }

    // MARK: - LayoutTabBar
    private func layoutTabBar() {

        let tabHeight: CGFloat = 93
        let tabWidth = self.view.frame.size.width

        var tabFrame = self.tabBar.frame
        tabFrame.size.height = tabHeight
        tabFrame.size.width = tabWidth
        tabFrame.origin.y = (self.view.frame.size.height - tabHeight) + 5
        tabFrame.origin.x = (self.view.frame.size.width - tabWidth) / 2
        self.tabBar.frame = tabFrame
    }
    
    // MARK: - SetTabBar
    private func setupTabBar() {
        
        let backgroundColor = UIColor.backgroundColor
        self.tabBar.barTintColor = backgroundColor
        self.tabBar.alpha = 0.6
        self.tabBar.tintColor = UIColor.primaryColor
        self.tabBar.unselectedItemTintColor = .white

        let borderLayer = CAShapeLayer()
        let maskLayer = CAShapeLayer()

        maskLayer.path = UIBezierPath(roundedRect: self.tabBar.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30, height: 0)).cgPath

        borderLayer.path = maskLayer.path
        borderLayer.lineWidth = 1.6
        borderLayer.strokeColor = UIColor.primaryColor?.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.frame = self.tabBar.bounds
        
        self.tabBar.layer.mask = maskLayer
        self.tabBar.layer.addSublayer(borderLayer)
        
    }
}

//final class TabBarController: UITabBarController {
//
//    // MARK: - Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setUpTabs()
//        setUI()
//    }
//
//    // MARK: - SetUI
//    private func setUI() {
//        tabBar.addShadow()
//        tabBar.backgroundColor = .secondarySystemGroupedBackground
//        tabBar.tintColor = .primaryColor
//    }
//
//    // MARK: - Setup Tabs
//    private func setUpTabs() {
//
//        let home = HomeController()
//        let cart = CartController()
//        let profile = ProfileController()
//
//        let nav1 = UINavigationController(rootViewController: home)
//        let nav2 = UINavigationController(rootViewController: cart)
//        let nav3 = UINavigationController(rootViewController: profile)
//
//        nav1.tabBarItem = UITabBarItem(title: "Ana Sayfa", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
//
//        nav2.tabBarItem = UITabBarItem(title: "Sepetim", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
//
//        nav3.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
//
//        setViewControllers(
//         [nav1, nav2, nav3],
//         animated: true)
//    }
//}
