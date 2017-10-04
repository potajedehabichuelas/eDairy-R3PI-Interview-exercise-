//
//  CurrencyPair.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

struct currencyExchangeKeys {
    static let quotes = "quotes"
    static let source = "source"
}

class CurrencyPair: NSObject {

    //CurrencyPair against USD
    var usdValue: Double
    var pairName: String
    
    override init() {
        self.pairName = ""
        self.usdValue = 0
    }
    
    convenience init(currencyName: String, currencyValue: Double) {
        
        self.init()
        self.pairName = currencyName
        self.usdValue = currencyValue
    }
}
