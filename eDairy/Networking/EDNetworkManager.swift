//
//  EDNetworkManager.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class EDNetworkManager: NSObject {

    //Singleton
    static let sharedInstance = EDNetworkManager()
    
    func getItemsForSale(completion: @escaping ([Product]?) -> Void) {
        //Ideally this would come from our server, but for this example we'll just read a JSON file
        
        DispatchQueue.global(qos: .background).async {
            
            //In a big shop this could take a while...
            guard let productsJSON = self.getTestProductsJSON() else {
                print("Error getting the products for the shop")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            var products = [Product]()
            for productDict in productsJSON {
                let newProduct = Product(itemDict: productDict)
                products.append(newProduct)
            }
            DispatchQueue.main.async {
                completion(products)
            }
        }
    }
    
    func getTestProductsJSON()-> [[String: Any]]?  {
        //Returns a JSON file with the available products for the shop
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "items", withExtension: "json") else {
            return nil
        }
        
        guard let dataContent = try? Data(contentsOf: url) else {
            return nil
        }
        
        guard let jsonString = try? JSONSerialization.jsonObject(with: dataContent, options:[]), let productsJson = jsonString as? [[String : Any]] else {
            return nil
        }
        
        return productsJson
    }
}
