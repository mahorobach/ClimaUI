//
//  WeatherModel.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/17.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let conditionName2: String
//    let iconCode: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.sun.rain"
        case 511...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
    /*
    var weatherIconURL: URL? {
            return URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")
        }
   */
}
