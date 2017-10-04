//
//  EDNetworkManager.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

struct CurrenciesUrl {
    static let exchangeCurrencies = "http://www.apilayer.net/api/live?access_key=93d2c61d00998a6759f27f919ea07240"
}

class EDNetworkManager: NSObject {

    //Singleton
    static let sharedInstance = EDNetworkManager()
    
    func getAvailableCurrencies(completion: @escaping ([CurrencyPair]?) -> Void) {
        
        let url = URL(string: CurrenciesUrl.exchangeCurrencies)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            do {
                guard let jsonDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] else { completion(nil); return }
                //Parse response into currency pairs
                
                guard let pairsDict = jsonDict[currencyExchangeKeys.quotes] as? [String : Any] else { completion(nil); return }
                
                var currencyArray = [CurrencyPair]()
                for pair in pairsDict  {
                    guard let value = pair.value as? Double else {
                        print("Error processing pair: value is not Double")
                        continue
                    }
                    let newPair = CurrencyPair(currencyName: pair.key, currencyValue: value)
                    currencyArray.append(newPair)
                }
                completion(currencyArray)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getItemsForSale(completion: @escaping ([String : Product]?) -> Void) {
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
            
            var products = [String :Product]()
            for productDict in productsJSON {
                let newProduct = Product(itemDict: productDict)
                products[newProduct.id] = newProduct
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
