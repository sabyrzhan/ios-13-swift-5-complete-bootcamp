//
//  WeatherManager.swift
//  Clima
//
//  Created by Sabyrzhan Tynybayev on 6/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ac4119e6c195057a1cd530ac6e9630d3&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if data != nil {
                    let weatherData = self.parse(data: data!)
                    if let weather = weatherData {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                } else {
                    print("Notthin happened")
                }
            }
            task.resume()
        } else {
            print("URL not buolt")
        }
    }
    
    func parse(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Weather.self, from: data)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weatherData = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weatherData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
