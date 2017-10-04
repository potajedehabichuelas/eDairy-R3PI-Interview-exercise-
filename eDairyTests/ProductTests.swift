//
//  ItemTests.swift
//  eDairyTests
//
//  Created by Daniel Bolivar herrera on 3/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

@testable import eDairy

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductInitializer() {
        
        let product = Product(name: "Peas", id: "234", price: 200, pricedescrip: "per kg")
        
        XCTAssertEqual(product.name, "Peas")
        XCTAssertEqual(product.id, "234")
        XCTAssertEqual(product.price, 200)
        XCTAssertEqual(product.priceDescription, "per kg")
    }
    
    func testProductJSONParser() {
        let bundle = Bundle(for: type(of: self))
        
        
        guard let url = bundle.url(forResource: "item", withExtension: "json") else {
            XCTFail("Missing file: item.json")
            return
        }
        
        guard let dataContent = try? Data(contentsOf: url) else {
            XCTFail("File content error: item.json")
            return
        }
        
        guard let jsonString = try? JSONSerialization.jsonObject(with: dataContent, options:[]), let jsonDict = jsonString as? [String : Any] else {
            XCTFail("File Item.json contains an invalid JSON String")
            return
        }
        
        let item: Product =  Product(itemDict: jsonDict)
        
        XCTAssertEqual(item.name, "Peas")
        XCTAssertEqual(item.id, "greenPeas13209")
        XCTAssertEqual(item.price, 0.95)
        XCTAssertEqual(item.priceDescription, "per bag")
    }
}
