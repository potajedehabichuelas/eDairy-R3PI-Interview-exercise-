//
//  CurrencyExchangeTests.swift
//  eDairyTests
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

@testable import eDairy

class CurrencyExchangeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCurrencyInitExample() {
        let pair = CurrencyPair(currencyName: "EURUSD", currencyValue: 1.18)
        
        XCTAssertEqual(pair.pairName, "EURUSD")
        XCTAssertEqual(pair.usdValue, 1.18)
    }    
}
