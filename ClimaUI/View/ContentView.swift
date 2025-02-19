//
//  ContentView.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationClient = LocationClient()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 0) {
                SearchBarView(
                    viewModel: viewModel,
                    locationClient: locationClient,
                    isFocused: $isFocused)
                HStack {
                    Spacer()
                    Image(systemName: viewModel.weatherData?.condition ?? "sun.max")
                        .foregroundColor(Color("WeatherColor"))
                        .font(.system(size: UIScreen.main.bounds.width / 4))
                        .padding(.trailing, 20)
                }
                
                .padding(.top, 5)
                
                HStack{
                    Spacer()
                    Text(String(format: "%.1f", viewModel.weatherData?.temperature ?? 10.0))
                        .fontWeight(.black)
                    
                    Text("°")
                        .fontWeight(.light)
                    
                    Text("C")
                        .fontWeight(.light)
                }
                .font(.system(size: 80))
                .foregroundColor(Color("WeatherColor"))
                .padding(.top, 5)
                .padding(.trailing, 20)
                
                HStack{
                    Spacer()
                    
                    Text(viewModel.weatherData?.cityLabel ?? "Tokyo")
                        .font(.system(size: 40))
                        .foregroundColor(Color("WeatherColor"))
                }
                .padding(.trailing, 20)
                Spacer()
                
                VStack {
                    Text("位置情報")
                        .foregroundColor(Color("WeatherColor"))
                    
                    if locationClient.requesting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("WeatherColor")))
                            .padding()
                    }
                    
                    /*
                     if  locationClient.lat != 0.0 || locationClient.lon != 0.0 {
                     Text("緯度：\(locationClient.lat, specifier: "%.4f")")
                     .foregroundColor(Color("WeatherColor"))
                     Text("経度：\(locationClient.lon, specifier: "%.4f")")
                     .foregroundColor(Color("WeatherColor"))
                     
                     */
                    if let location = locationClient.location {
                        Text("緯度：\(location.latitude, specifier: "%.4f")")
                            .foregroundColor(Color("WeatherColor"))
                        Text("経度：\(location.longitude, specifier: "%.4f")")
                            .foregroundColor(Color("WeatherColor"))
                    } else if !locationClient.requesting {
                        Text("緯度：----")
                            .foregroundColor(Color("WeatherColor"))
                        Text("経度：----")
                            .foregroundColor(Color("WeatherColor"))
                    }
                }
                .padding(.bottom, 40)
                
                Spacer()
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
