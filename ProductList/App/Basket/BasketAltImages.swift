//
//  BasketAltImages.swift
//  ProductList
//
//  Created by Phil Martin on 18/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BasketAltImages: View {
    
    // MARK: - Properties
    var url: URL
    
    // MARK: - Main Body
    var body: some View {
        WebImage(url: url)
            .resizable() // Resizable like
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: FloatConstants.animationFadeDuration)) // Fade Transition with duration
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: FloatConstants.defaultThumbnailWidthHeight, height: FloatConstants.defaultThumbnailWidthHeight)
    }
}
