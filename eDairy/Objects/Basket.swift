//
//  Basket.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class Basket: NSObject {
    
    public private(set) var items: [String : Int] //Dictionary of Product name (must be unique) (key) and amount of that item (value)
    
    override init() {
        self.items = Dictionary()
    }
    
    func addProduct(product: Product) {
        
        if let productAmount = self.items[product.id] {
            //If product exist, add one
            self.items[product.id] = productAmount+1
        } else {
            //Add key if it does not exist
            self.items[product.id] = 0
        }
    }
    
    func removeProduct(product: Product) {
        
        if let productAmount = self.items[product.id] {
            //If product exist, add one
            if productAmount == 1 {
                self.items.removeValue(forKey: product.id)
            } else {
                self.items[product.id] = productAmount-1
            }
        } else {
            print("Error: Trying to remove a product that is not in the basket")
        }
    }
}
