//
//  Products.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, productDescription: String
    let price: Int
    let discountPercentage, rating: Float
    let stock: Int
    let brand, category, thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }

}
