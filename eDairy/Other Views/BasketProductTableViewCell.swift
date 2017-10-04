//
//  BasketProductTableViewCell.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

public let basketCellId = "BasketCellId"

protocol BasketProductCellDelegate {
    func addProductToBasket(productId: String)
    func removeProductFromBasket(productId: String)
}

class BasketProductTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var delegate:BasketProductCellDelegate?
    var productId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removeProduct(_ sender: Any) {
        
        guard let prodId = self.productId else {
            print("Basket cell: Modifying product that is not set")
            return
        }
    
        self.delegate?.removeProductFromBasket(productId: prodId)
    }
   
    @IBAction func addProduct(_ sender: Any) {
        
        guard let prodId = self.productId else {
            print("Basket cell: Modifying product that is not set")
            return
        }
        
        self.delegate?.addProductToBasket(productId: prodId)
    }
}
