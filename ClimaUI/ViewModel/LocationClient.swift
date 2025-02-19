//
//  LocationClient.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/19.
//

import Foundation
import CoreLocation

class LocationClient : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocationCoordinate2D?
    @Published var requesting: Bool = false
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    weak var weatherViewModel: WeatherViewModel?
    
    override init() {
        super.init()
        locationManager.delegate = self
        authorizationStatus = locationManager.authorizationStatus
        locationManager.requestLocation()
    }
    
    func requestLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            requesting = true
            locationManager.requestLocation()
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse {
            requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let lastLocation = locations.last {
            
            location = lastLocation.coordinate
            requesting = false
            print("位置情報取得成功- 緯度: \(lastLocation.coordinate.latitude), 経度: \(lastLocation.coordinate.longitude)")
            // コールバックで位置情報を通知
            onLocationUpdate?(lastLocation.coordinate)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("位置情報取得エラー: \(error.localizedDescription)")
        requesting = false
    }
    
    
    private func request() {
        if (locationManager.authorizationStatus == .authorizedWhenInUse) {
            requesting = true
            locationManager.requestLocation()
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
