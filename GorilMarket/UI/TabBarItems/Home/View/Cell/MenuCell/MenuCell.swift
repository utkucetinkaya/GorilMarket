//
//  MenuCell.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import UIKit
import Kingfisher

protocol MenuCellDelegate: AnyObject {
    func addMealToCart(foodItem: Food)
}

class MenuCell: UICollectionViewCell {
    
    // MARK: - UI Element
    @IBOutlet weak private var menuBackgroundView: UIView!
    @IBOutlet weak private var foodNameLabel: UILabel!
    @IBOutlet weak private var foodPricaLabel: UILabel!
    @IBOutlet weak private var foodImageView: UIImageView!
    @IBOutlet weak private var imageBackgroundView: UIView!
    
    // MARK: - Properties
    var foodItem: Food?
    weak var delegate: MenuCellDelegate?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: - Setup UI
    private func setUI() {
        // background
        menuBackgroundView.setBorder(width: 1.5, color: UIColor.systemGray6)
        menuBackgroundView.addBottomShadow()
        menuBackgroundView.setCorner(radius: 10)
        // imageview
        foodImageView.addBottomShadow()
    }
    
    // MARK: - SetCell
    func setCell(foodItem: Food) {
        self.foodItem = foodItem
        foodNameLabel.text = "\(foodItem.name ?? "")"
        foodPricaLabel.text = "₺\(foodItem.price ?? ""),00"
        
        let imageUrl = URL(string: Constants.shared.imageURL + "\(foodItem.imageName ?? "")")
        foodImageView.kf.setImage(with: imageUrl)
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.indicator?.view.backgroundColor = .primaryColor
        foodImageView.kf.indicator?.view.setCorner(radius: 6)
        foodImageView.kf.setImage(with: imageUrl,placeholder: nil,options: [.transition(.fade(0.7))])
    }
    
    // MARK: - AddCartAction
    @IBAction func addCartButtonTapped(_ sender: Any) {
        guard let foodItem = foodItem else { return }
        delegate?.addMealToCart(foodItem: foodItem)
    }
}
