//
//  BasketCard.swift
//  ProductList
//
//  Created by Phil Martin on 18/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BasketCard: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var fetchedData: ProductItem
    @State private var isEnabled = true
    
    private let imageHeight: CGFloat = 160
    
    // MARK: - Main Body
    var body: some View {
            VStack {
                Text(fetchedData.title ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                basketQuantityView
                
                WebImage(url: URL(string: fetchedData.thumbnailURL ?? "")!)
                    .resizable() // Resizable like
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: FloatConstants.animationFadeDuration)) // Fade Transition with duration
                    .scaledToFit()
                    .frame(maxWidth: .infinity, minHeight: imageHeight)
                    .padding()
               
                extraImageView
                
                Text(StringConstants.productInformationTitle)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                Text(fetchedData.productDescription ?? "")
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                Text("Price \(fetchedData.stringPrice)")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.orange)
                    .padding(.top)
            }
            .padding()
    }
    
    // MARK: - Views
    var basketQuantityView: some View{
        VStack {
            Text(StringConstants.basketQuantityTitle)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            HStack {
                Button {
                    DatabaseManager().updateQuantity(product: fetchedData, quantity: -1, context: viewContext)
                    checkAgainstStock()
                } label: {
                    Image(systemName: StringConstants.minusQuantityIcon)
                        .font(.system(size: FloatConstants.buttonIconFontSize))
                        .foregroundColor(.orange)
                }
                Text("\(fetchedData.quantity)")
                Button {
                    DatabaseManager().updateQuantity(product: fetchedData, quantity: 1, context: viewContext)
                    checkAgainstStock()
                } label: {
                    Image(systemName: StringConstants.plusQuantityIcon)
                        .font(.system(size: FloatConstants.buttonIconFontSize))
                        .foregroundColor(.orange)
                }
                .disabled(!isEnabled)
                .opacity(isEnabled ? FloatConstants.enabledOpacity : FloatConstants.disabledOpacity)
                Spacer()
                Button {
                    DatabaseManager().removeFromBasket(object: fetchedData, context: viewContext)
                } label: {
                    Text(StringConstants.deleteButtonTitle)
                        .padding(.top, FloatConstants.padding / 2)
                        .padding(.bottom, FloatConstants.padding / 2)
                        .padding(.leading, FloatConstants.padding / 2)
                        .padding(.trailing, FloatConstants.padding / 2)
                        .foregroundColor(.primary)
                        .background(.gray)
                        .cornerRadius(FloatConstants.cornerRadius)
                }
            }
            .padding()
        }.overlay(
            RoundedRectangle(cornerRadius: FloatConstants.cornerRadius / 2)
                .stroke(.orange.opacity(FloatConstants.disabledOpacity), lineWidth: FloatConstants.boardWidth)
        )
    }
    
    var extraImageView: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(fetchedData.imageUrls ?? [], id: \.self) { url in
                    BasketAltImages(url: URL(string: url)!)
                }
            }
        }.scrollIndicators(.hidden)
    }
    
    // MARK: - Helpers
    private func checkAgainstStock()  {
        isEnabled = fetchedData.isLessMaxStock
    }
}
