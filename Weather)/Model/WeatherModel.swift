//
//  WeatherModel.swift
//  Weather)
//
//  Created by I9orila T on 30.04.2022.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        return String (format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId  {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snowflake"
        case 701...781:
            return "humidity"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
}

