//
//  ProductTableViewCell.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

public let productCellId = "productCellId"

protocol ProductCellDelegate {
    func addProductToBasket(product: Product)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var bgroundView: UIView!
    @IBOutlet weak var priceDescription: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var product: Product?
    var delegate:ProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgroundView.layer.borderColor = UIColor(red: 41/255, green: 163/255, blue: 41/255, alpha: 1.0).cgColor
    }
    
    @IBAction func buyProduct(_ sender: Any) {
        self.addProduct()
    }
    
    func addProduct() {
        
        guard let prod = self.product else {
            print("Product cell: Buying product that is not set")
            return
        }
        animateBorderWidth(view: self.bgroundView, from: 3, to: 0, duration: 0.3)
        
        self.delegate?.addProductToBasket(product: prod)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
