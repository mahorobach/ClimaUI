//
//  BackgroundView.swift
//  ClimaUI
//
//  Created by 赤尾浩史 on 2025/02/15.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
            
            
                .clipped()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}

