//
//  CustomCell3.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/15/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class CustomCell3: UITableViewCell {
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UIButton!
    var studentIdReciver = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
