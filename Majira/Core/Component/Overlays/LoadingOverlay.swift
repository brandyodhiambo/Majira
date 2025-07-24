//
//  LoadingOverlay.swift
//  Majira
//
//  Created by Brandy Odhiambo on 15/07/2025.
//

import SwiftUI
import Lottie

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black.opacity(0.3))
                .ignoresSafeArea()

            LottieView(animationName: "flying-weather")
                .frame(width: 70, height: 70)
        }
    }
}
