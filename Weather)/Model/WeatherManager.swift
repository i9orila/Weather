//
//  WeatherManager.swift
//  Weather)
//
//  Created by I9orila T on 30.04.2022.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=1ec77e201fc906871fa472d21c1bb6dd&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest (urlString: urlString)
    }
    
    func performRequest (urlString: String) {   //выполнить запрос
        //1 create URL
        if let url = URL (string: urlString) {
            // 2 create URL session
            let session = URLSession(configuration: .default)
            // 3 give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            // 4 start the task
            task.resume()
        }
        
    }
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather.description)
            print(decodedData.weather[0].id)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            
        } catch {
            print(error)
        }
        
    }
    
}

