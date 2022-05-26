//
//  WeatherManager.swift
//  Weather)
//
//  Created by I9orila T on 30.04.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=1ec77e201fc906871fa472d21c1bb6dd&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest (with: urlString)
    }
    
    func performRequest (with urlString: String) {   //выполнить запрос
        //1 create URL
        if let url = URL (string: urlString) {
            // 2 create URL session
            let session = URLSession(configuration: .default)
            // 3 give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    }
                }
                // 4 start the task
                task.resume()
            }
            
        }
        func parseJSON(_ weatherData: Data) -> WeatherModel? {
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
                return weather
                print(weather.conditionName)
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
                
            }
            
        }
        
    }



