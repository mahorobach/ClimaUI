//
//  ContentView.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/14.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @FocusState private var isFocused: Bool
    
    private func performSearch() {
        print("検索しているのは：\(searchText)")
        searchText = ""
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                
                    .clipped()
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 6) {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(Color("WeatherColor"))
                        
                        HStack {
                            TextField("都市名を入力してください。", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .foregroundColor(Color("WeatherColor"))
                                .submitLabel(.search)
                                .onSubmit {
                                    performSearch()
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
                        
                        Button(action: performSearch){
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
                
                HStack {
                    Spacer()
                    Image(systemName: "sun.max")
                        .foregroundColor(Color("WeatherColor"))
                        .font(.system(size: UIScreen.main.bounds.width / 4))
                        .padding(.trailing, 20)
                }
                .padding(.top, 5)
                
                
                HStack{
                    Spacer()
                    Text("21")
                        .font(.system(size: 80))
                        .foregroundColor(Color("WeatherColor"))
                        .fontWeight(.black)
                    Text("°")
                        .font(.system(size: 80))
                        .foregroundColor(Color("WeatherColor"))
                        .fontWeight(.light)
                    Text("C")
                        .font(.system(size: 80))
                        .foregroundColor(Color("WeatherColor"))
                        .fontWeight(.light)
                }
                .padding(.top, 5)
                .padding(.trailing, 20)
                
                HStack{
                    Spacer()
                    Text("Tokyo")
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
