//
//  MenuCell.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import UIKit
import Kingfisher

class MenuCell: UICollectionViewCell {
    
    // MARK: - UI Element
    @IBOutlet weak private var menuBackgroundView: UIView!
    @IBOutlet weak private var foodNameLabel: UILabel!
    @IBOutlet weak private var foodPricaLabel: UILabel!
    @IBOutlet weak private var foodImageView: UIImageView!
    @IBOutlet weak private var imageBackgroundView: UIView!
    
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
    func setCell(price: String,name: String, id: String) {
        foodNameLabel.text = name
        foodPricaLabel.text = ("₺\(price),00")
        
        let imageUrl = URL(string: Constants.shared.imageURL + "\(id)")
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.indicator?.view.backgroundColor = .primaryColor
        foodImageView.kf.indicator?.view.setCorner(radius: 6)
        foodImageView.kf.setImage(with: imageUrl,placeholder: nil,options: [.transition(.fade(0.7))])
    }

    // MARK: - IBAction
    @IBAction func addToCartTapped(_ sender: Any) {
    }
}
