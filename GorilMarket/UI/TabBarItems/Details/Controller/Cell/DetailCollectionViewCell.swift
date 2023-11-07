//
//  DetailCollectionViewCell.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 3.11.2023.
//

import UIKit

protocol DetailCollectionViewCellDelegate: AnyObject {
    func didTapAddToCart(foodItem: Food)
}

class DetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var backgroundImageView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    
    // MARK: - Properties
    var foodItem: Food?
    weak var delegate: DetailCollectionViewCellDelegate?
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView?.addShadow(color: UIColor.lightGray, radius: 3.0, opacity: 2.0, offset: CGSize(width: 1, height: 2))
        backgroundImageView.setBorder(width: 1, color: UIColor.systemGray5)
    }
    
    // MARK: - SetCell
    func setCell(imageName: String, price: String, name: String) {
        // image
        let imageUrl = URL(string: Constants.shared.imageURL + "\(imageName)")
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator?.view.backgroundColor = .primaryColor
        imageView.kf.indicator?.view.setCorner(radius: 6)
        imageView.kf.setImage(with: imageUrl,placeholder: nil,options: [.transition(.fade(0.7))])
        //label
        priceLabel.text = "₺\(price),00"
        nameLabel.text = name
    }
    
    // MARK: - IBAction
    @IBAction func addCartButton(_ sender: Any) {
        
        print("Add Cart Tiklandi")
        if let foodItem = foodItem {
            delegate?.didTapAddToCart(foodItem: foodItem)
        }
    }
}
