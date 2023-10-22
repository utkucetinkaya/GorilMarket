//
//  OnboardingSlide.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 12.10.2023.
//

import UIKit

// MARK: - Onboarding Model
struct Slide {
    let title: String?
    let desc: String?
    let imageName: String?
    
    // MARK: - Collection
    static let collection: [Slide] = [
        Slide(title: "Lezzetli Yemekler", desc: "Dünyanın dört bir yanındaki farklı kültürlerden çeşitli harika yemekleri deneyimleyin", imageName: "slide1"),
        
        Slide(title: "Dünya Standartlarında Şefler", desc: "Yemeklerimiz sadece en iyiler tarafından hazırlanmaktadır.", imageName: "slide2"),
        
        Slide(title: "Anında Teslimat", desc: "Siparişleriniz dünyanın neresinde olursanız olun anında teslim edilir.", imageName: "slide3")
    ]
}
