//
//  WeatherViewModel.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/15.
//

import SwiftUI
import CoreLocation


class WeatherViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var weatherData: ContentModel?
    
    var weatherManager: WeatherManager
    
    
    init() {
        weatherManager = WeatherManager()
        weatherManager.delegate = self
    }
    func performSearch() {
        Task {
            await weatherManager.fetchWeatherData(cityName: searchText)
        }
    }
    
    func fetchWeatherWithLocation(location: CLLocationCoordinate2D) {
        Task {
            await weatherManager.fetchWeatherData(
                latitude: location.latitude,
                longitude: location.longitude
            )
        }
    }    
}

//MARK: - WeatherViewModel Delegate

extension WeatherViewModel: WeatherManagerDelegate  {
    func didUpdateWeather(weatherManager: WeatherManager,weatherModel: WeatherModel) {
        
        Task {
            weatherData = ContentModel(
                temperature: weatherModel.temperature,
                cityLabel: weatherModel.cityName,
                condition: weatherModel.conditionName
                //              iconURL: weatherModel.weatherIconURL
            )
            
            searchText = ""
        }
    }
    
    func didFailWithError(_ error: Error) {
        print("Error fetching weather data: \(error)")
    }
}
//MARK: - <#Section Heading #>
//MARK: - <#Section Heading #>
