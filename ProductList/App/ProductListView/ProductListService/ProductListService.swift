//
//  ProductListService.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import Foundation

enum ProductListService {
    case getAllProdducts
}

extension ProductListService: Endpoint {
    
    var path: String {
        switch self {
        case .getAllProdducts:
            return "products"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getAllProdducts:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .getAllProdducts:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getAllProdducts:
            return nil
        }
    }
    
}
