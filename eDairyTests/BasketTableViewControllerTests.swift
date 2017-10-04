//
//  BasketTableViewControllerTests.swift
//  eDairyTests
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

@testable import eDairy

class BasketTableViewControllerTests: XCTestCase {
    
    var basketControllerUnderTest: BasketTableViewController!
    var storage: EDStorage = EDStorage()
    
    override func setUp() {
        super.setUp()
    
        self.basketControllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: basketTableViewControllerSbId) as! BasketTableViewController
    }
    
    override func tearDown() {
        self.basketControllerUnderTest = nil
        super.tearDown()
    }
    
    func testBasketTotalValue() {
        //Add some products to the basket
        let productPrice = Double(arc4random_uniform(99))
        let product: Product = Product(name: "Peas", id: "234", price: productPrice, pricedescrip: "per kg")
        let timesAdded = Int(arc4random_uniform(99))
        //Also add product to the available products
        EDStorage.sharedInstance.availableProducts[product.id] = product
        
        for _ in 0 ..< timesAdded {
            self.basketControllerUnderTest.basket.addProduct(product: product)
        }
        
        XCTAssertEqual(self.basketControllerUnderTest.calculateBasketTotalPrice(), productPrice * Double(timesAdded))
    }
    
}
