//
//  CustomCell2.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/10/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class CustomCell2: UITableViewCell {
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var space: UILabel!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var studentButton: UIButton!
    var carIdReciver = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
