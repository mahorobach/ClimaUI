//
//  WeatherManager.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/16.
//

import Foundation

struct WeatherManager {
    weak var delegate: WeatherManagerDelegate?
    
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=c007688e74f3ab420d90af1ac4721e00"
    
    
    
    func fetchWeatherData(cityName: String) async {
        let urlString = "\(weatherURL)&q=\(cityName)"
        guard let url = URL(string: urlString) else {
            delegate?.didFailWithError(URLError(.badURL))
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weather = parseJSON(weatherData: data) {
                 delegate?.didUpdateWeather(weatherModel: weather)
            }
        } catch {
            delegate?.didFailWithError(error)
        }
        
    }
    
    func parseJSON(weatherData: Data)  -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Welcome.self, from: weatherData)
            return WeatherModel(
                conditionId: decodeData.weather[0].id,
                cityName: decodeData.name,
                temperature: decodeData.main.temp
            )
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

protocol WeatherManagerDelegate: AnyObject {
    func didUpdateWeather(weatherModel: WeatherModel)
    func didFailWithError(_ error: Error)
}
