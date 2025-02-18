//
//  WeatherViewModel.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/15.
//

import SwiftUI

class WeatherViewModel: ObservableObject, WeatherManagerDelegate {
    @Published var searchText: String = ""
    @Published var weatherData: WeatherData?
    
    private var weatherManager: WeatherManager
    
    init() {
        weatherManager = WeatherManager()
        weatherManager.delegate = self
    }
    func performSearch() {
        Task {
            await weatherManager.fetchWeatherData(cityName: searchText)
        }
    }
    
    func didUpdateWeather(weatherModel: WeatherModel) {
        Task {
            weatherData = WeatherData(
                temperature: weatherModel.temperature,
                cityName: weatherModel.cityName,
                condition: weatherModel.conditionName
            )
            searchText = ""
        }
        }
    
    func didFailWithError(_ error: Error) {
            print("Error fetching weather data: \(error)")
        }
    
    
  
}
