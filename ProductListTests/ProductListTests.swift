//
//  ProductListTests.swift
//  ProductListTests
//
//  Created by Phil Martin on 17/10/2022.
//

import XCTest
@testable import ProductList

final class ProductListTests: XCTestCase, HTTPClient {
    
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        expectation = nil
    }
    
    @MainActor
    func testAPIIntegration() {
        expectation = expectation(description: "Fetch Products")
        Task {
            expectation?.fulfill()
            let result = await getAllProducts()
            switch result {
            case .success(let model):
                XCTAssertTrue(model.products.count > 0)
            case .failure(_):
               XCTFail("API Failed")
            }
        }
        waitForExpectations(timeout: 2)

    }
    
    private func getAllProducts() async -> Result<Products, RequestError> {
        return await sendRequest(endpoint: ProductListService.getAllProdducts, responseModel: Products.self)
    }
}
