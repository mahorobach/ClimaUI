//
//  SearchBarView.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/15.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel : WeatherViewModel
    @ObservedObject var locationClient: LocationClient
    @FocusState.Binding var isFocused: Bool
    
    init(viewModel: WeatherViewModel, locationClient: LocationClient, isFocused: FocusState<Bool>.Binding) {
        self.viewModel = viewModel
        self.locationClient = locationClient
        self._isFocused = isFocused
        
        locationClient.onLocationUpdate = { coordinate in
                viewModel.fetchWeatherWithLocation(location: coordinate)
            }
        }
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Button(action: {
                    locationClient.requestLocation()
                    
                }) {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color("WeatherColor"))
                    
                }
                
                HStack {
                    TextField("都市名を入力してください。", text: $viewModel.searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(Color("WeatherColor"))
                        .submitLabel(.search)
                        .onSubmit {
                            viewModel.performSearch()
                        }
                        .focused($isFocused)
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("TextField tapped")  // デバッグ用
                    isFocused = true
                }
                
                Button(action: viewModel.performSearch){
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundStyle(Color("WeatherColor"))
                        .frame(width: 24)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)
        }
    }
}
/*
 #Preview {
 SearchBarView()
 }
 
 */
