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
    @IBOutlet weak private var nameView: UIView!
    @IBOutlet weak private var addCartButton: UIButton!
    @IBOutlet weak private var detailImageView: UIImageView!
    @IBOutlet weak private var detailName: UILabel!
    @IBOutlet weak private var detailPrice: UILabel!
    @IBOutlet weak private var quantityLabel: UILabel!
    @IBOutlet weak private var stepper: UIStepper!
    
    // MARK: - Properties
    var item: Food?
    private let viewModel = DetailViewModel()
    var stepperValue = 1
    var price = 1
    var priceLabel = 1
    var total = 1
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
    }
        
    // MARK: - SetData
    private func setData() {
        detailName.text = item?.name
        detailPrice.text = ("₺\(item?.price ?? ""),00")
        detailImageView.kf.setImage(with: URL(string: Constants.shared.imageURL + (item?.imageName ?? "")))
        detailImageView.kf.indicatorType = .activity
    }
    
    // MARK: - SetUI
    private func setUI() {
        addCartButton.setCorner(radius: 15)
        addCartButton.setBorder(width: 2, color: UIColor.secondaryColor ?? .clear)
        nameView.addShadow()
        nameView.setBorder(width: 2, color: UIColor.systemGray4)
        nameView.setCorner(radius: 8)
        // navBar&target
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - IBActions
    @IBAction func addCartButtonTapped(_ sender: Any) {
        if quantityLabel.text == "0" {

            showPopUp(title: "Sepete Ürün Eklendi", text: "Lütfen adet giriniz.", buttontext: "Tamam")
           
        } else {

            if let mealName = item?.name, let mealImageName = item?.imageName, let mealPrice = item?.price, let orderQuantity = quantityLabel.text, let username = Constants.shared.username {
                
                viewModel.addMealToCart(mealName: mealName, mealImageName: mealImageName, mealPrice: mealPrice, mealOrderQuantity: orderQuantity, username: username)
    
                guard let quantity = Int(quantityLabel.text ?? "0") else { return }
    
                let total = quantity * (Int(mealPrice) ?? 0)
                
                guard let mealName = item?.name else { return }
                
                showPopUp(title: "Sepete Ürün Eklendi", text: "\(quantity) adet \(mealName) sepete eklendi. Toplam : \(total)₺", buttontext: "Tamam")
            }
        }
    }
    
    // MARK: - StepperTapped
    @IBAction func stepperTapped(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
        stepperValue = Int(sender.value)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cartButtonTapped(_ sender: Any) {
        let vc = CartController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
