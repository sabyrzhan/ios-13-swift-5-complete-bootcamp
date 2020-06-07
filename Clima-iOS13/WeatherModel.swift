//
//  WeatherModel.swift
//  Clima
//
//  Created by Sabyrzhan Tynybayev on 6/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        var result = "cloud"
        switch conditionId {
            case 200...232:
                result = "cloud.bolt"
            case 300...321:
                result = "cloud.drizzle"
            case 500...531:
                result = "cloud.rain"
            case 600...622:
                result = "cloud.snow"
            case 700...781:
                result = "cloud.fog"
            case 800:
                result = "sun.max"
            case 801...804:
                result = "cloud.bolt"
            default:
                result = "cloud"
        }
        return result
    }
}
