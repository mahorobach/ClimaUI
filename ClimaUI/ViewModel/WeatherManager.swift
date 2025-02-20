//
//  WeatherManager.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/16.
//

import Foundation
import CoreLocation

struct WeatherManager {
    
    weak var delegate: WeatherManagerDelegate?
    
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=myid"
    
    private func makeWeatherURL(cityName: String? = nil, lat: Double? = nil, lon: Double? = nil) -> URL?{
        var urlString = weatherURL
        
        if let cityName = cityName {
            urlString += "&q=\(cityName)"
        } else if let lat = lat, let lon = lon {
            urlString += "&lat=\(lat)&lon=\(lon)"
        } else {
            return nil
        }
        return URL(string: urlString)
    }
    
    func fetchWeatherData(cityName: String) async {
        guard let url = makeWeatherURL(cityName: cityName) else {
            delegate?.didFailWithError(URLError(.badURL))
            return
        }
        await fetchWeather(url: url)
    }
    
    func fetchWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        guard let url = makeWeatherURL(lat: latitude, lon: longitude) else {
            delegate?.didFailWithError(URLError(.badURL))
            return
        }
        await fetchWeather(url: url)
    }
    
    private func fetchWeather(url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON:", jsonString)
                    }            
            
            if let weather = parseJSON(weatherData: data) {
                await delegate?.didUpdateWeather(weatherManager: self, weatherModel: weather)
                print(url)
            }
        } catch {
            delegate?.didFailWithError(error)
        }
        
    }
}
extension WeatherManager {
    func parseJSON(weatherData: Data)  -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Welcome.self, from: weatherData)
            return WeatherModel(
                conditionId: decodeData.weather[0].id,
                cityName: decodeData.name,
                temperature: decodeData.main.temp,
                conditionName2: decodeData.weather[0].main
                //          iconCode: decodeData.weather[0].icon
            )
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }    
}

protocol WeatherManagerDelegate: AnyObject {
    @MainActor func didUpdateWeather(weatherManager: WeatherManager,weatherModel: WeatherModel)
    func didFailWithError(_ error: Error)
}
