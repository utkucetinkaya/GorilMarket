//
//  CampaignCell.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import UIKit

class CampaignCell: UICollectionViewCell {

    // MARK: - UI Elements
    @IBOutlet weak private var campaignImageView: UIImageView!
    
    // MARK: - SetCell
    func setCell(image: UIImage) {
        campaignImageView.image = image
        campaignImageView.setCorner(radius: 50)
    }
}
