//
//  ProductItem+CoreDataClass.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//
//

import Foundation
import CoreData

@objc(ProductItem)
public class ProductItem: NSManagedObject {

    var stringPrice: String {
        return "£\(price)"
    }
    
    var isLessMaxStock: Bool {
        return quantity < stockQuantity
    }
}
