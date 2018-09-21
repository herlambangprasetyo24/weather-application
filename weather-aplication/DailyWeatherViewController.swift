//
//  DailyWeatherViewController.swift
//  weather-aplication
//
//  Created by Herlambang Prasetyo on 9/21/18.
//  Copyright © 2018 Herlambang Prasetyo. All rights reserved.
//

import UIKit

class DailyWeatherViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dailyTableView: UITableView!
    @IBOutlet weak var headlineWeatherImage: UIImageView!
    @IBOutlet weak var headlineWeatherDescription: UILabel!
    @IBOutlet weak var headLineDate: UILabel!
    
    var weatherAPI: WeatherAPI!
    var weatherData: NSDictionary = NSDictionary()
    var dailyWeather: Array<NSDictionary> = Array<NSDictionary>()
    var selectedDate: NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Jakarta"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherAPI = WeatherAPI()
        onGetWeather(locationKey: "208971")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            onGetLocationKey(location: searchBar.text!)
            
        }
    }
    
    func onGetLocationKey(location: String) {
        weatherAPI.getLocationKey(location: location) { (locationKey) in
            if locationKey != "" {
                self.onGetWeather(locationKey: locationKey!)
            }
        }
    }
    
    func onGetWeather(locationKey: String) {
        weatherAPI.getAccuWeather(locationKey: locationKey) { (data) in
            if data != nil {
                self.weatherData = data!
                self.setHeadlineUI()
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherListCell", for: indexPath) as! DailyWeatherListCell
        let dateTimeStamp = dailyWeather[indexPath.section].object(forKey: "EpochDate") as! Int
        var dateString = convertDate(unixtimeInterval: Double(dateTimeStamp))
        let dayData = dailyWeather[indexPath.section].object(forKey: "Day") as! NSDictionary
        let imageName = dayData.object(forKey: "Icon") as! Int
        let temperatureData = dailyWeather[indexPath.section].object(forKey: "Temperature") as! NSDictionary
        let minimumTemperatureData = temperatureData.object(forKey: "Minimum") as! NSDictionary
        let maximumTemperaturedata = temperatureData.object(forKey: "Maximum") as! NSDictionary
        let minimumTemperature = minimumTemperatureData.object(forKey: "Value") as! Int
        let maximumTemperature = maximumTemperaturedata.object(forKey: "Value") as! Int
        let unit = minimumTemperatureData.object(forKey: "Unit") as! String
        
        if indexPath.section == 0 {
            dateString = "Today"
            cell.date.textColor = UIColor.black
            cell.temperature.textColor = UIColor.black
        }
        cell.date.text = dateString
        cell.weatherImage.image = UIImage(named: "\(imageName)")
        cell.temperature.text = "\(minimumTemperature)°\(unit) - \(maximumTemperature)°\(unit)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = dailyWeather[indexPath.section]
        self.performSegue(withIdentifier: "hourly", sender: selectedData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hourly" {
            if let destinationVC = segue.destination as? DailyDetailViewController {
                destinationVC.selectedData = sender as! NSDictionary
            }
        }
        
    }
    
    func setHeadlineUI() {
        let headlineData = weatherData.object(forKey: "Headline") as! NSDictionary
        dailyWeather = weatherData.object(forKey: "DailyForecasts") as! Array<NSDictionary>
        let title = headlineData.object(forKey: "Text") as? String
        let imageName = headlineData.object(forKey: "Category") as! String
        let image = UIImage(named: imageName)
        let dateTimeStamp = headlineData.object(forKey: "EffectiveEpochDate") as! Int
        let dateString = convertDate(unixtimeInterval: Double(dateTimeStamp))
        
        headlineWeatherImage.image = image
        headlineWeatherDescription.text = title!
        headLineDate.text = dateString
        
        dailyTableView.reloadData()
        headlineWeatherImage.image = UIImage(named: "headlineIcon")
    }

    func convertDate(unixtimeInterval: Double) -> String {
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM dd,yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}
