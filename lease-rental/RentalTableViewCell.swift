//
//  RentalTableViewCell.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 2/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

class RentalTableViewCell: UITableViewCell {

    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var rental: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
