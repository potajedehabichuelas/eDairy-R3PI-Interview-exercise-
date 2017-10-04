//
//  eDairyTests.swift
//  eDairyTests
//
//  Created by Daniel Bolivar herrera on 3/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

@testable import eDairy

class eDairyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddItemBasket() {
        let basket = Basket()
        let product: Product = Product(name: "Peas", id: "234", price: 200, pricedescrip: "per kg")
        basket.addProduct(product: product)
        //Check there is only one item
        XCTAssertEqual(basket.items.count, 1)
        
        //Check the id of the product is the same
        for productId in basket.items.keys {
            XCTAssertEqual(productId, product.id)
        }
    }
    
    func testRemoveBasketProduct() {
        let basket = Basket()
        let product: Product = Product(name: "Peas", id: "234", price: 200, pricedescrip: "per kg")
        basket.removeProduct(product: product)
        XCTAssertEqual(basket.items.count, 0)
    }
}
