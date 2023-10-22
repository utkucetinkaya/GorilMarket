//
//  OnboardingCell.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 12.10.2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    // MARK: - UI Elements
    @IBOutlet weak private var slideImageView: UIImageView!
    @IBOutlet weak private var slideDescLabel: UILabel!
    @IBOutlet weak private var slideTitleLabel: UILabel!
    
    // MARK: - Set Cell
    func setCell(slide: Slide) {
        slideImageView.image = UIImage(named: slide.imageName ?? "")
        slideTitleLabel.text = slide.title
        slideDescLabel.text = slide.desc
    }
}
