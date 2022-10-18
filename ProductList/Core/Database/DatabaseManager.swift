//
//  DatabaseManager.swift
//  ProductList
//
//  Created by Phil Martin on 18/10/2022.
//

import Foundation
import CoreData

class DatabaseManager: ObservableObject {
    
    let container = NSPersistentContainer(name: "ProductList")

    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func add(product: Product, context: NSManagedObjectContext) {
        let item = ProductItem(context: context)
        item.id = Int16(product.id)
        item.stockQuantity = Int16(product.stock)
        item.title = product.title
        item.thumbnailURL = product.thumbnail
        item.price = Int16(product.price)
        item.productDescription = product.productDescription
        let urls = product.images.compactMap({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
        item.imageUrls = urls
        save(context: context)
    }
    
    func addToBasket(product: ProductItem, context: NSManagedObjectContext) {
        product.isInBasket = true
        save(context: context)
    }
    
    func updateQuantity(product: ProductItem, quantity: Int, context: NSManagedObjectContext) {
        product.quantity += Int16(quantity)
        save(context: context)
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeFromBasket(object: ProductItem, context: NSManagedObjectContext) {
        object.isInBasket = false
        object.quantity = 0
        save(context: context)
    }
    
}
