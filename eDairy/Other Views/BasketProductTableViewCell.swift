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
    func addProductToBasket(product: Product)
    func removeProductFromBasket(product: Product)
}

class BasketProductTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var delegate:BasketProductCellDelegate?
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removeProduct(_ sender: Any) {
        
        guard let prod = self.product else {
            print("Basket cell: Modifying product that is not set")
            return
        }
    
        self.delegate?.removeProductFromBasket(product: prod)
    }
   
    @IBAction func addProduct(_ sender: Any) {
        
        guard let prod = self.product else {
            print("Basket cell: Modifying product that is not set")
            return
        }
        
        self.delegate?.addProductToBasket(product: prod)
    }
}
