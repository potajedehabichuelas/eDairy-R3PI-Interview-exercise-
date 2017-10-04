//
//  CheckoutTableViewController.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var checkOutPrice: Double = 0.0
    var currenctyPairs: [CurrencyPair] = Array() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var filteredCurrencies: [CurrencyPair] = Array()
    
    var searchController: UISearchController!
    var shouldShowSearchResults = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()

        self.configureSearchController()
        
        //Get currency pair data
        EDNetworkManager.sharedInstance.getAvailableCurrencies(completion: { currencies in

            if let currencyData = currencies {
                DispatchQueue.main.async {
                    self.currenctyPairs = currencyData
                }
            } else {
                print("Error getting currency pair exchange data")
            }
           
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currency"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        self.tableView.tableHeaderView = searchController.searchBar
        
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.shouldShowSearchResults = true
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.shouldShowSearchResults = false
        self.tableView.reloadData()
        self.view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !self.shouldShowSearchResults {
            self.shouldShowSearchResults = true
            self.tableView.reloadData()
        }
        
        self.searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text?.lowercased() else { return }
        // Filter the data array and get only those countries that match the search text.

        self.filteredCurrencies = self.currenctyPairs.flatMap({ currency in
            if currency.pairName.lowercased().range(of: searchString) != nil {
                return currency
            } else {
                return nil
            }
        })
        
        // Reload the tableview.
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source & Delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if self.shouldShowSearchResults {
                return self.filteredCurrencies.count
            } else {
                return self.currenctyPairs.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //We only want spacing for the first section, it doesn't look as good in the others :P (the tableview frame seems biased)
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: basketTotalCellId, for: indexPath) as! BasketTotalTableViewCell
        
        if indexPath.section == 0 {
            //Display value in USD
            cell.totalPrice.text = " $ \(self.checkOutPrice)"
            cell.backgroundColor = .white
        } else {
            
            let currency: CurrencyPair
            if self.shouldShowSearchResults {
                currency = self.filteredCurrencies[indexPath.row]
            } else {
                currency = self.currenctyPairs[indexPath.row]
            }
            
            //Display value in other currencies
            cell.backgroundColor = UIColor(red: 222/255, green: 230/255, blue: 230/255, alpha: 1.0)
            cell.totalPrice.text = "\(currency.getCurrencyTag()) \(self.checkOutPrice * currency.usdValue)"
        }

        return cell
    }

}
