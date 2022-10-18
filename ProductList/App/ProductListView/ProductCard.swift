//
//  ProductCard.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCard: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isEnabled = true
    
    var fetchedData: ProductItem
    private let spacing: CGFloat = 10
    
    // MARK: - Main Body
    var body: some View {
        VStack(alignment: .leading, content: {
            itemImage
            addToBasketButton
            
        })
        .padding([.leading, .trailing, .bottom])
        .overlay(
            RoundedRectangle(cornerRadius: FloatConstants.cornerRadius)
                .stroke(.gray.opacity(FloatConstants.grayBoardOpactity), lineWidth: FloatConstants.boardWidth)
            )
    }
    
    
    // MARK: - Views
    var addToBasketButton: some View {
        Button {
            DatabaseManager().addToBasket(product: fetchedData, context: viewContext)
            DatabaseManager().updateQuantity(product: fetchedData, quantity: 1, context: viewContext)
            checkAgainstStock()
            
        } label: {
            Image(systemName: StringConstants.cartIcon)
                .foregroundColor(.white)
            Text(StringConstants.addToBasketButtonTitle)
                .foregroundColor(.white)
                .padding()
                .lineLimit(nil)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? FloatConstants.enabledOpacity : FloatConstants.disabledOpacity)
        .lineLimit(nil)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .cornerRadius(FloatConstants.cornerRadius)
    }
    
    var itemImage: some View {
        HStack {
            WebImage(url: URL(string: fetchedData.thumbnailURL ?? "")!)
                .resizable() // Resizable like
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: FloatConstants.animationFadeDuration)) // Fade Transition with duration
                .scaledToFill()
                .frame(width: FloatConstants.defaultThumbnailWidthHeight, height: FloatConstants.defaultThumbnailWidthHeight)
                .clipShape(Circle())
                .padding()
            VStack(alignment: .leading, spacing: spacing, content: {
                Text(fetchedData.title ?? "")
                    .font(.body)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(fetchedData.stringPrice)
                    .font(.body)
                    .foregroundColor(.gray)
            })
        }
    }
    
    // MARK: - Helpers
    private func checkAgainstStock()  {
        isEnabled = fetchedData.isLessMaxStock
    }

}

