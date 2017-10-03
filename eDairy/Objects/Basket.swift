//
//  Basket.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class Basket: NSObject {
    
    var totalPrice: Double
    var items: [Item]
    
    override init() {
        self.items = Array()
        self.totalPrice = 0
    }
}
