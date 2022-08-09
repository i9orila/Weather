//
//  ViewController.swift
//  Weather)
//
//  Created by I9orila T on 30.04.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
}

//MARK: - UITextFielDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // убирает клавиатуру при нажатии кнопри поиск search
        print (searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  //функция срабатывания кнопки поиск на клавиатуре, нужен протокол UI Text field delegate
        searchTextField.endEditing(true) // убирает клавиатуру при нажатии кнопри return/go
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return  true
        } else {
            textField.placeholder = "Type something..."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = " "
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        print(weather.temperature)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
