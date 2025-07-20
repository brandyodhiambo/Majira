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

            VStack(spacing: 16) {
                Text("Oops!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.theme.onSurfaceColor)
                Text(message)
                    .foregroundColor(.theme.onSurfaceColor)
                    .multilineTextAlignment(.center)

                Button(action: onRetry) {
                    Text("Retry")
                        .foregroundColor(.theme.onPrimaryColor)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.theme.primaryColor)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.theme.surfaceColor)
            .cornerRadius(12)
            .shadow(radius: 20)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.95)
            .padding()
        }
    }
}
