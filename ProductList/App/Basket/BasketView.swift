//
//  BasketView.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import SwiftUI

struct BasketView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ProductItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ProductItem.title, ascending: true)], predicate: NSPredicate(format: "quantity > 0 && isInBasket == true")) var results: FetchedResults<ProductItem>
    
    // MARK: - Computed Properties
    var basketTotal: String {
        var total = 0
        results.forEach { item  in
            total += Int(item.price * item.quantity)
        }
        return "£\(total)"
    }
    
    // MARK: - Main Body
    var body: some View {
        VStack {
            if results.isEmpty {
                Spacer()
                Text(StringConstants.basketIsEmptyTitle)
                    .font(.title)
                    .bold()
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 5, content: {
                        ForEach(results, id: \.id) { product in
                            BasketCard(fetchedData: product)
                                .background(.clear)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.gray.opacity(0.2), lineWidth: 1)
                                    )
                                .padding()
                              
                            
                        }.onDelete { index in
                            removeFromBasket(at: index)
                        }
                    })
                }
                .padding(.bottom)
                
                HStack{
                    Text(StringConstants.basketTotalTitle)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(basketTotal)
                        .font(.title3)
                        .bold()
                }
                .padding()
                .background(.orange)
            }
        }.navigationTitle(StringConstants.basketNavigationTitle)
    }
    
    // MARK: - Private Helper
    private func removeFromBasket(at offsets: IndexSet) {
        for index in offsets {
                let language = results[index]
            DatabaseManager().removeFromBasket(object: language, context: viewContext)
            }
       }

}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
