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
    
    func performSearch() {
        print("検索しているのは：\(searchText)")
        weatherData = WeatherData(
            temperature : 21.0,
            cityName : searchText,
            condition: "sun.max"
        )
        searchText = ""
    }
}
