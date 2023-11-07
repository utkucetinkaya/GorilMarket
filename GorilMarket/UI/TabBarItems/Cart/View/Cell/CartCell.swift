//
//  CartCell.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 19.10.2023.
//

import UIKit
import Kingfisher

protocol FavoriteDeleteProtocol {
    func favoriteDelete(indexPath: IndexPath)
}

final class CartCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var cartNameLabel: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var orderLabel: UILabel!
    
    // MARK: - Properties
    var indexPath : IndexPath?
    var favoriteDeleteProtocol: FavoriteDeleteProtocol?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCellView.setCorner(radius: 13)
        backgroundCellView.addShadow(color: UIColor.lightGray, radius: 3.0, opacity: 2.0, offset: CGSize(width: 1, height: 2))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        favoriteDeleteProtocol?.favoriteDelete(indexPath: indexPath ?? [])
    }
    
    // MARK: - SetCell
    func setCell(price: String,name: String, imageName: String, order: String) {
        //label
        cartNameLabel.text = name
        cartPriceLabel.text = ("₺\(price),00")
        orderLabel.text = ("\(order) adet")
        
        //image view
        let imageUrl = URL(string: Constants.shared.imageURL + "\(imageName)")
        cartImageView.kf.indicatorType = .activity
        cartImageView.kf.indicator?.view.backgroundColor = .primaryColor
        cartImageView.kf.indicator?.view.setCorner(radius: 6)
        cartImageView.kf.setImage(with: imageUrl,placeholder: nil,options: [.transition(.fade(0.7))])

    }
}
