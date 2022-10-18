//
//  ProductListViewModel.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import Foundation
import CoreData
 
class ProductListViewModel: ObservableObject, HTTPClient {
    
    @Published var products: [Product] = []
    @Published var errorMessage = ""
    
    // MARK: - Database
    func saveProducts(context: NSManagedObjectContext) {
        products.forEach { product in
            DatabaseManager().add(product: product, context: context)
        }
    }
    
    // MARK: - Request
    @MainActor
    func fetchProducts(context: NSManagedObjectContext) {
        Task {
            let result = await getAllProducts()
            switch result {
            case .success(let model):
                self.products = model.products
                self.saveProducts(context: context)
            case .failure(let error):
                self.errorMessage = error.customMessage
            }
        }
    }
    
    // MARK: - Private Helper
    private func getAllProducts() async -> Result<Products, RequestError> {
        return await sendRequest(endpoint: ProductListService.getAllProdducts, responseModel: Products.self)
    }
    
}
