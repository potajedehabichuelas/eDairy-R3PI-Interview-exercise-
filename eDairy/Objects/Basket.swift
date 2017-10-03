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
    var items: [String : Int] //Dictionary of Product name (must be unique) (key) and amount of that item (value)
    
    override init() {
        self.items = Dictionary()
        self.totalPrice = 0
    }
}
