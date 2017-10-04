//
//  BasketTotalTableViewCell.swift
//  eDairy
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

public let basketTotalCellId = "basketTotalCellId"

class BasketTotalTableViewCell: UITableViewCell {

    @IBOutlet weak var totalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
