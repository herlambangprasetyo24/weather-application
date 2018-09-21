//
//  HourlyTableViewController.swift
//  weather-aplication
//
//  Created by Herlambang Prasetyo on 9/22/18.
//  Copyright © 2018 Herlambang Prasetyo. All rights reserved.
//

import UIKit

class DailyDetailViewController: UITableViewController {
    
    @IBOutlet var dailyDetailTableView: UITableView!
    var selectedData: NSDictionary = NSDictionary()
    var dailyDetailData: Array<NSDictionary> = Array<NSDictionary>()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        dailyDetailTableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getData() {
        let dayData = selectedData.object(forKey: "Day") as! NSDictionary
        let nightData = selectedData.object(forKey: "Night") as! NSDictionary
        dailyDetailData.append(dayData)
        dailyDetailData.append(nightData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dailyDetailData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyDetailCell", for: indexPath) as! DailyDetailCell
        let detailData = dailyDetailData[indexPath.section]
        let time = indexPath.section == 0 ? "Day" : "Night"
        let imageName = detailData.object(forKey: "Icon") as! Int
        let windData = detailData.object(forKey: "Wind") as! NSDictionary
        let windSpeedData = windData.object(forKey: "Speed") as! NSDictionary
        let windSpeed = windSpeedData.object(forKey: "Value") as! Double
        let windUnit = windSpeedData.object(forKey: "Unit") as! String
        let windDirectionData = windData.object(forKey: "Direction") as! NSDictionary
        let windDirection = windDirectionData.object(forKey: "English") as! String
        let rain = detailData.object(forKey: "HoursOfRain") as! Double
        
        
        cell.time.text = time
        cell.imageView?.image = UIImage(named: "\(imageName)")
        cell.wetherDescription.text = detailData.object(forKey: "ShortPhrase") as! String
        cell.temperature.text = "Rain : \(rain) Hours"
        cell.windSpeed.text = "Wind Speed : \(windSpeed) \(windUnit)"
        cell.windDirection.text = "Wind Direction : \(windDirection)"
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
