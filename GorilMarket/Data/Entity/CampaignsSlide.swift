//
//  CampaignsSlide.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import Foundation

// MARK: - Campaings Slide
struct CampaignSlide {
    let imageName: String?
    
    // MARK: - Collection
    static let collection: [CampaignSlide] = [
        CampaignSlide(imageName: "campaign1"),
        CampaignSlide(imageName: "campaign2"),
        CampaignSlide(imageName: "campaign3")
    ]
}
