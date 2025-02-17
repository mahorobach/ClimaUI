//
//  WeatherViewModel.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/15.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var weatherData: WeatherData?
    
    var weatherManager = WeatherManager()
    
    func performSearch() {
        Task {
            await fetchWeather()
        }
    }
    
    @MainActor
    private func fetchWeather() {
        Task {
            do {
                let data =  try await weatherManager.fetchWeatherData(cityName: searchText)
                if let dataString = String(data: data, encoding: .utf8) {
                  //  print("データ変換できました。")
                    /*
                    if let weatherInfo = weatherManager.parseJSON(weatherData: data){
                        updateWeatherData(
                            temperature: weatherInfo.temperature,
                            cityName: weatherInfo.cityName,
                            weather: weatherInfo.weather
                        )
                    }
                     */
                     if let weatherInfo = weatherManager.parseJSON(weatherData: data){
                         updateWeatherData(
                            temperature: weatherInfo.temperature,
                            cityName: weatherInfo.cityName,
                            conditionName: weatherInfo.conditionName
                         )
                     }
                     
                    
                } else {
                    print("データを変換できませんでした")
                }
                
                searchText = ""
            } catch {
                print("Error fetching weathre data: \(error)")
            }
        }
    }
    
    func updateWeatherData(temperature: Double, cityName: String, conditionName: String) {
        
        weatherData =  WeatherData(
            temperature:  temperature,
            cityName: cityName,
            condition: conditionName)
    }
}
