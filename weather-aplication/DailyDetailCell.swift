//
//  DailyDetailCell.swift
//  weather-aplication
//
//  Created by Herlambang Prasetyo on 9/22/18.
//  Copyright © 2018 Herlambang Prasetyo. All rights reserved.
//

import UIKit

class DailyDetailCell: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var wetherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
