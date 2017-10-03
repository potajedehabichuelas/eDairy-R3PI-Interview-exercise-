//
//  Product.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 3/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

struct itemKeys {
    static let name = "name"
    static let price = "price"
    static let priceDescription = "priceDescription"
}

class Product: NSObject {

    var name: String
    var price: Double
    var priceDescription: String
    
    
    override init() {
        self.name = ""
        self.priceDescription = ""
        self.price = 0
    }
    
    convenience init(itemDict: [String: Any]) {
        
        self.init()
        
        if let iName = itemDict[itemKeys.name] as? String {
            self.name = iName
        }
        
        if let iPriceDes = itemDict[itemKeys.priceDescription] as? String {
            self.priceDescription = iPriceDes
        }
        
        if let iPrice = itemDict[itemKeys.price] as? Double {
            self.price = iPrice
        }
    }
}
