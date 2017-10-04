//
//  BasketTableViewController.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class BasketTableViewController: UITableViewController, BasketProductCellDelegate {

    var basket = EDStorage.sharedInstance.basket
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Remove extra separators
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        //Disable or enable scrolling if the content is bigger than the tableview frame
        if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
            self.tableView.isScrollEnabled = true;
        } else {
            self.tableView.isScrollEnabled = false;
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return basket.items.values.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: basketCellId, for: indexPath) as! BasketProductTableViewCell
            
            let productId = Array(self.basket.items.keys)[indexPath.row]
            
            guard let product = EDStorage.sharedInstance.availableProducts[productId], let amount = self.basket.items[product.id] else { return cell}
            
            cell.product = product
            cell.delegate = self
            cell.name.text = product.name
            cell.amount.text = "\(amount)"
            cell.totalPrice.text = "$ \(product.price * Double(amount))"
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: basketTotalCellId, for: indexPath) as! BasketTotalTableViewCell
            cell.totalPrice.text = " $ \(self.calculateBasketTotalPrice())"
            
            return cell
        }
    }
    
    func calculateBasketTotalPrice() -> Double {
        
        var totalPrice = 0.0
        
        for item in self.basket.items {
            let prodId = item.key
            guard let product = EDStorage.sharedInstance.availableProducts[prodId], let amount = self.basket.items[product.id] else {
                print("Error Calculating basket total price: Product not found")
                continue
            }
            totalPrice += product.price * Double(amount)
        }
        
        return totalPrice
    }
    
    // MARK: - BasketProductCellDelegate
    
    func addProductToBasket(product: Product) {
        
        EDStorage.sharedInstance.basket.addProduct(product: product)
        self.tableView.reloadData()
    }
    
    func removeProductFromBasket(product: Product) {
        
        EDStorage.sharedInstance.basket.removeProduct(product: product)
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
