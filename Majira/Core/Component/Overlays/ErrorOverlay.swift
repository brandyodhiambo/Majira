//
//  ErrorOverlay.swift
//  Majira
//
//  Created by Brandy Odhiambo on 15/07/2025.
//
import SwiftUI

struct ErrorOverlay: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black.opacity(0.4))
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Oops!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Text(message)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Button(action: onRetry) {
                    Text("Retry")
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}
