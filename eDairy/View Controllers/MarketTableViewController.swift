//
//  MarketTableViewController.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class MarketTableViewController: UITableViewController, ProductCellDelegate {

    var shopProducts = [Product]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()

        //Get the products
        EDNetworkManager.sharedInstance.getItemsForSale(completion: { products in
            if let prodDictionary = products {
                self.shopProducts = Array(prodDictionary.values)
                EDStorage.sharedInstance.availableProducts = prodDictionary
            }
        })
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
    
    // MARK: - ProductCell Delegate
    
    func addProductToBasket(productId: String) {
        
        guard let product = EDStorage.sharedInstance.availableProducts[productId] else { return }
        //Add Item to the basket
        EDStorage.sharedInstance.basket.addProduct(product: product)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.shopProducts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as! ProductTableViewCell
        
        let item = self.shopProducts[indexPath.section]
        
        cell.delegate = self
        cell.productId = item.id
        cell.name.text = item.name
        cell.price.text = "$ \(item.price)"
        cell.priceDescription.text = item.priceDescription

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView()
        
        view.backgroundColor = UIColor(red: 222/255, green: 230/255, blue: 230/255, alpha: 1.0)
        
        return bgView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow, let cell = self.tableView.cellForRow(at: selectedIndexPath) as? ProductTableViewCell else { return}
        cell.addProduct()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
