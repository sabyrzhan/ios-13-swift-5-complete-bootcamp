//
//  Weather.swift
//  Clima
//
//  Created by Sabyrzhan Tynybayev on 6/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let name: String
    let main: Main
    let weather: [SubWeather]
}

struct Main: Codable {
    let temp: Double
}

struct SubWeather : Codable {
    let id: Int
    let description: String
}
