//
//  ContentView.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 0) {
                SearchBarView(viewModel: viewModel, isFocused: $isFocused)
                
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
                    Text(viewModel.weatherData?.cityName ?? "Tokyo")
                        .font(.system(size: 40))
                        .foregroundColor(Color("WeatherColor"))
                }
                .padding(.trailing, 20)
                Spacer()
                
                Text("Hello, world!")
                    .foregroundColor(Color("WeatherColor"))
                Spacer()
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
