//
//  DailyWeatherListCell.swift
//  weather-aplication
//
//  Created by Herlambang Prasetyo on 9/21/18.
//  Copyright © 2018 Herlambang Prasetyo. All rights reserved.
//

import UIKit

class DailyWeatherListCell: UITableViewCell {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
