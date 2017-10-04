//
//  NetworkManagerTests.swift
//  eDairyTests
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

@testable import eDairy

class NetworkManagerTests: XCTestCase {
    
    var managerUnderTest: EDNetworkManager!
    
    override func setUp() {
        super.setUp()
        self.managerUnderTest =  EDNetworkManager()
    }
    
    override func tearDown() {
        self.managerUnderTest = nil
        super.tearDown()
    }
    
    func testCurrencyRatesRequest() {
        
        let ex = expectation(description: "Expecting Currency Exchange Data")
        
        self.managerUnderTest.getAvailableCurrencies(completion: { currencies in
            
            XCTAssertNotNil(currencies)
            if let currencyData = currencies {
                XCTAssertGreaterThanOrEqual(currencyData.count, 0)
            }
            ex.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
