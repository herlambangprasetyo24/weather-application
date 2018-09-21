//
//  WeatherAPI.swift
//  weather-aplication
//
//  Created by Herlambang Prasetyo on 9/22/18.
//  Copyright © 2018 Herlambang Prasetyo. All rights reserved.
//

import UIKit

class WeatherAPI: NSObject {
    
    let host: String = "http://dataservice.accuweather.com/"
    let apiKey: String = "YICm8alUGl7FD9FRw56UXtVggWTGOjIe"
    
    func getLocationKey(location: String, completion: @escaping (String?) -> ()) {
        let locationFilter = location.replacingOccurrences(of: " ", with: "")
        let locationURL = "\(host)locations/v1/cities/search?apikey=OrRtXjGMBfn81UXGqFPNdJj4pWQZzbAy&q=\(locationFilter)&language=id-ID&details=true&offset=10"
        var locationKey = ""
        let url : URL = URL(string: locationURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error: Error?) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                        print(json)
                        let locationArray = json as! Array<NSDictionary>
                        if !locationArray.isEmpty {
                            locationKey = locationArray[0].object(forKey: "Key") as! String
                            completion(locationKey)
                        } else {
                            completion("")
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getAccuWeather(locationKey: String, completion: @escaping (NSDictionary?) -> ()) {
        let forecastURL = "\(host)forecasts/v1/daily/5day/\(locationKey)?apikey=\(apiKey)&language=en-US&details=true&metric=false"
        let url : URL = URL(string: forecastURL)!
        let request = URLRequest(url: url)
        
        var weatherData: NSDictionary = NSDictionary()
        
        let task = URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error: Error?) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        weatherData = json as! NSDictionary
                        if weatherData.object(forKey: "Code") == nil {
                            let dailyForecasts = weatherData.object(forKey: "DailyForecasts") as! Array<NSDictionary>
                            print(dailyForecasts)
                            DispatchQueue.main.async {
                                completion(weatherData)
                            }
                        }
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                
            }
        }
        task.resume()
    }

}
