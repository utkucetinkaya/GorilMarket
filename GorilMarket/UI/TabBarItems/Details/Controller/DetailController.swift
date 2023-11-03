//
//  DetailController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 18.10.2023.
//

import UIKit
import Kingfisher

class DetailController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak private var bottomView: UIView!
    @IBOutlet weak private var addCartButton: UIButton!
    @IBOutlet weak private var detailImageView: UIImageView!
    @IBOutlet weak private var detailName: UILabel!
    @IBOutlet weak private var totalLabel: UILabel!
    @IBOutlet weak private var quantityLabel: UILabel!
    @IBOutlet weak private var stepper: UIStepper!
    @IBOutlet private weak var detailPriceLabel: UILabel!
    @IBOutlet private weak var detailCollectionView: UICollectionView!
    
    // MARK: - Properties
    var item: Food?
    private let viewModel = DetailViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
    }
    
    // MARK: - SetData
    private func setData() {
        quantityLabel.text = "\(Int(stepper.value))"
        detailPriceLabel.text = "₺\(item?.price ?? "").00"
        detailName.text = item?.name
        totalLabel.text = "₺0.00"
        detailImageView.kf.setImage(with: URL(string: Constants.shared.imageURL + (item?.imageName ?? "")))
        detailImageView.kf.indicatorType = .activity
    }
    
    // MARK: - SetUI
    private func setUI() {
        // component
        addCartButton.setCorner(radius: 15)
        addCartButton.setBorder(width: 0.5, color: UIColor.backgroundColor ?? .clear)
        bottomView.setCorner(radius: 50)
        stepper.setCorner(radius: 13)
        // navBar
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - IBActions
    @IBAction func addCartButtonTapped(_ sender: Any) {
        if quantityLabel.text == "0" {
            
            showPopUp(title: "Uyarı!", text: "Lütfen adet giriniz.", buttontext: "Tamam")
            
        } else {
            
            if let mealName = item?.name, let mealImageName = item?.imageName, let mealPrice = item?.price, let orderQuantity = quantityLabel.text, let username = Constants.shared.username {
                
                viewModel.addMealToCart(mealName: mealName, mealImageName: mealImageName, mealPrice: mealPrice, mealOrderQuantity: orderQuantity, username: username)
                
                guard let quantity = Int(quantityLabel.text ?? "1") else { return }
                guard let mealName = item?.name else { return }
                let total = quantity * (Int(mealPrice) ?? 0)
                
                showPopUp(title: "Sepete Ürün Eklendi", text: "\(quantity) adet \(mealName) sepete eklendi. Toplam : \(total)₺", buttontext: "Tamam")
                quantityLabel.text = "\(Int(stepper.value))"
            }
        }
    }
    
    // MARK: - StepperTapped
    @IBAction func stepperTapped(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
        guard let price = Double(item?.price ?? "") else { return }
        let totalPrice = price * Double(sender.value)
        totalLabel.text = ("₺ \(totalPrice)0")
    }
    
    // MARK: - BackButton
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CartButton
    @IBAction func cartButtonTapped(_ sender: Any) {
        let vc = CartController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
