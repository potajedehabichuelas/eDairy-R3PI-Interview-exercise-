//
//  EDStorage.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class EDStorage: NSObject {

    //Singleton
    static let sharedInstance = EDStorage()
    
    var basket: Basket = Basket()
    
    var availableProducts: [String : Product] = Dictionary() //Key would be id of product - value would be product
}
