//
//  CustomCell.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/9/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventButton: UIButton!
    var eventIdReciver = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
