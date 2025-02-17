//
//  WeatherManager.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/16.
//

import Foundation

struct WeatherManager {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=c007688e74f3ab420d90af1ac4721e00"
    
    func fetchWeatherData(cityName: String) async throws -> Data {
        let urlString = "\(weatherURL)&q=\(cityName)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func parseJSON(weatherData: Data)  -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Welcome.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
}
