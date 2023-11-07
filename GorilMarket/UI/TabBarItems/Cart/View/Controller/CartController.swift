//
//  CartController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import UIKit

class CartController: UIViewController {
    
    // MARK: - UI Elements

    @IBOutlet weak private var cartTableView: UITableView!
    @IBOutlet weak private var totalLabel: UILabel!
    @IBOutlet weak private var checkoutButton: UIButton!
    @IBOutlet weak private var totalView: UIView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var loadingView: UIView! {
        didSet {
            loadingView.setCorner(radius: 6)
        }
    }
    
    // MARK: - Properties
    var cartModel: [CartModel]?
    let viewModel = CartViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerTableView()
        showSpinner()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerViewModel()
    }
    
    // MARK: - SetUI
    private func setUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        checkoutButton.setBorder(width: 1, color: UIColor.primaryColor ?? .clear)
        checkoutButton.setCorner(radius: 10)
        totalLabel.text = "₺0,00"
        totalView.setCorner(radius: 13)
    }
    
    // MARK: - ShowSpinner
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
    
    // MARK: - HideSpinner
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    // MARK: - RegisterTableView
    private func registerTableView() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(UINib(nibName: CartCell.nameOfClass, bundle: nil), forCellReuseIdentifier: CartCell.nameOfClass)
    }
    
    // MARK: - RegisterViewModel
    private func registerViewModel() {
        viewModel.delegate = self
        viewModel.fetchCartMeals(username: Constants.shared.username ?? "")
    }
    
    // MARK: - GetTotal
    private func getTotalCart() {
        var total = 0
        var price = 0
        for food in cartModel ?? [] {
            price = Int(food.price!)! * Int(food.order!)!
            total += price
            totalLabel.text = "\(total)₺"
        }
    }
    
    // MARK: - IBActions
    @IBAction func checkoutTapped(_ sender: Any) {
        showAlert(title: "", message: "Sepetiniz Onaylandi.")
    }
}

// MARK: - CartResponseProtocol
extension CartController: FetchCartMealsResponseProtocol {

    func fetchCartSuccess(cart: [CartModel]) {
        self.cartModel = cart
        hideSpinner()
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
    func failFetchCart(error: String) {
        print(error)
        hideSpinner()
    }
}

// MARK: - UITableViewDelegate&DataSource
extension CartController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.nameOfClass, for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let cart = cartModel?[indexPath.row]
        let price = cart?.price
        let name = cart?.name
        let imageName = cart?.imageName
        let order = cart?.order
        cell.setCell(price: price ?? "", name: name ?? "", imageName: imageName ?? "", order: order ?? "")
        cell.favoriteDeleteProtocol = self
        cell.indexPath = indexPath
        getTotalCart()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let cart = self.cartModel?[indexPath.row]
            if let order = cart?.order, let name = cart?.name {
                let alert = UIAlertController(title: "Dikkat!", message: "\(order) adet \(name) silinsin mi?", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
                alert.addAction(cancelAction)

                let yesAction = UIAlertAction(title: "Evet", style: .destructive) { action in

                    self.viewModel.deleteMealFromCart(cartID: cart?.cartID ?? "", username: Constants.shared.username ?? "")
                    self.cartModel?.remove(at: indexPath.row)
                    self.cartTableView.deleteRows(at: [indexPath], with: .top)
                    self.getTotalCart()
                    tableView.reloadData()

                    if self.cartModel?.count == 0 {

                        let alert = UIAlertController(title: "Dikkat!", message: "Sepetinizde hiçbir ürün bulunmamaktadır.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Tamam", style: .cancel) {_ in
                        }

                        alert.addAction(action)

                        self.present(alert, animated: true)
                        self.totalLabel.text = "0₺"
                    }
                }

                alert.addAction(yesAction)
                self.present(alert, animated: true)
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - FavoriteDeleteProtocol
extension CartController: FavoriteDeleteProtocol {
    func favoriteDelete(indexPath: IndexPath) {
        let cart = self.cartModel?[indexPath.row]
        viewModel.deleteMealFromCart(cartID: cart?.cartID ?? "", username: Constants.shared.username ?? "")
        cartModel?.remove(at: indexPath.row)
        cartTableView.deleteRows(at: [indexPath], with: .top)
        cartTableView.reloadData()
    }
}
