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
    @IBOutlet weak private var detailPriceLabel: UILabel!
    @IBOutlet weak private var detailCollectionView: UICollectionView!
    
    // MARK: - Properties
    var item: Food?
    var meals: [Food]?
    private let viewModel = DetailViewModel()
    private let mealsViewModel = MealsViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
        registerCollectionView()
        registerViewModel()
        setCollectionViewLayout()
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
    
    // MARK: - RegisterViewModel
    private func registerViewModel() {
        mealsViewModel.delegate = self
        mealsViewModel.fetchAllMeals()
    }
    
    // MARK: - RegisterCollectionView
    private func registerCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.register(UINib(nibName: DetailCollectionViewCell.nameOfClass, bundle: nil),forCellWithReuseIdentifier: DetailCollectionViewCell.nameOfClass)
    }
    
    // MARK: - CollectionViewLayout
    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        detailCollectionView.backgroundColor = UIColor.clear
        detailCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - AddCartButtonActions
    @IBAction func addCartButtonTapped(_ sender: Any) {
        guard let quantityText = quantityLabel.text, let quantity = Int(quantityText), quantity > 0 else {
            showPopUp(title: "Uyarı!", text: "Lütfen adet giriniz.", buttontext: "Tamam")
            return
        }
        
        guard let mealName = item?.name,
              let mealImageName = item?.imageName,
              let mealPrice = item?.price,
              let username = Constants.shared.username else {
            print("Ürün bilgileri eksik.")
            return
        }
        
        viewModel.addMealToCart(mealName: mealName,
                                mealImageName: mealImageName,
                                mealPrice: mealPrice,
                                mealOrderQuantity: quantityText,
                                username: username) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    // Sepete ekleme işlemi başarılı olduğunda bir alert göster
                    let total = quantity * (Int(mealPrice) ?? 0)
                    self?.showPopUp(title: "Başarılı", text: "\(quantity) adet \(mealName) sepete eklendi. Toplam: \(total)₺", buttontext: "Tamam")
                    self?.quantityLabel.text = "\(quantity)"
                case .failure(let error):
                    // Hata meydana geldiğinde bir alert göster
                    self?.showPopUp(title: "Hata", text: "Ürün sepete eklenemedi: \(error.localizedDescription)", buttontext: "Tamam")
                }
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
    
    // MARK: - NavigateDetail
    private func navigateDetail(for indexPath: IndexPath) {
        let item = meals?[indexPath.row]
        let detailController = DetailController()
        detailController.item = item
        detailController.modalPresentationStyle = .pageSheet
        present(detailController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, DataSource
extension DetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        meals?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.nameOfClass, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let foodItem = meals?[indexPath.item] {
            cell.foodItem = foodItem
            cell.delegate = self
            cell.setCell(imageName: foodItem.imageName ?? "", price: String(foodItem.price ?? ""), name: foodItem.name ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateDetail(for: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - Fetch Meals Response
extension DetailController: MealsResponseProtocol {
    func mealsFetchSuccess(meals: [Food]) {
        self.meals = meals
        detailCollectionView.reloadData()
    }
}

// MARK: - CellAddCartDelegate
extension DetailController: DetailCollectionViewCellDelegate {
    func didTapAddToCart(foodItem: Food) {
        viewModel.addMealToCart(
            mealName: foodItem.name ?? "",
            mealImageName: foodItem.imageName ?? "",
            mealPrice: String(foodItem.price ?? ""),
            mealOrderQuantity: "1",
            username: Constants.shared.username ?? ""
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.showToast(message: "\(foodItem.name ?? "") Sepete Eklendi ☑️")
                case .failure(let error):
                    self?.showAlert(title: "Error!", message: "\(error)")
                }
            }
        }
    }
}
