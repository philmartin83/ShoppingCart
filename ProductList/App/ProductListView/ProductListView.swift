//
//  ProductListView.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    // MARK: - Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ProductItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ProductItem.title, ascending: true)]) var results: FetchedResults<ProductItem>
    
    // MARK: - Properties
    @ObservedObject private var vm = ProductListViewModel()
    @State private var path = NavigationPath()
    @State private var showBadge = false
    private let pathId = "Basket"
    
    // MARK: - Computed Properties
    var totalBasket: Int {
        let content = results.filter({$0.quantity > 0})
        var counter = 0
        content.forEach { item in
            counter += Int(item.quantity)
        }
        return counter
    }
    
    // MARK: - Main Body
    var body: some View {
        NavigationStack(path: $path, root: {
            VStack {
                if results.isEmpty {
                    Spacer()
                    ProgressIndicator()
                        .onAppear{
                            vm.fetchProducts(context: viewContext)
                        }
                    Spacer()
                    
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(results, id: \.id) { product in
                                ProductCard(fetchedData: product)
                                    .background(.clear)
                                    .padding()
                            }
                        }
                        
                    }
                }
            }.navigationTitle(StringConstants.productTitle)
                .toolbar {
                    basketBarButton
                }
        })
    }
    
    // MARK: - Views
    var basketBarButton: some View {
        Button(action: {
            self.path.append(pathId)
        }) {
            Image(systemName: StringConstants.cartIcon)
                .foregroundColor(.primary)
                .overlay {
                    if results.filter({$0.quantity > 0}).count > 0 {
                        Badge(count: totalBasket)
                    }
                }
        }
        .navigationDestination(for: String.self) { view in
            if view == pathId {
                BasketView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    @StateObject private static var dataController = DatabaseManager()
    static var previews: some View {
        ProductListView().environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
