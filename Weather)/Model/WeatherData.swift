//
//  WeatherData.swift
//  Weather)
//
//  Created by I9orila T on 30.04.2022.
//

import Foundation

struct WeatherData : Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}
 
struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
