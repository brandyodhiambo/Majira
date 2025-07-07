//
//  LandingPageView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct LandingPageView: View {
    @State private var animatedTitle = ""
    @State private var animatedSubtitle = ""
    var onGetStarted: () -> Void = {}


    var body: some View {
        VStack(spacing: 60){
   
            Image("sunRain")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 250)
                .foregroundColor(Color.theme.primaryColor)
            
            VStack(spacing: 5) {
                Text(animatedTitle)
                    .font(.custom("Poppins-Bold", size: 30))
                    .foregroundColor(Color.theme.primaryColor)

                Text(animatedSubtitle)
                    .font(.custom("Poppins-Light", size: 14))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.theme.onSurfaceColor)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))

            }
            CustomButtonView(
                buttonName:"Get Started",
                onTap: {
                    onGetStarted()
                }
            )

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Rectangle()
                .fill(LinearGradient(colors: [Color.theme.primaryColor, Color.theme.surfaceColor], startPoint: .top, endPoint: .bottom))
                .cornerRadius(20)
                .ignoresSafeArea(edges: .all)
        )
        .onAppear {
            Utils.shared.typeText("Majira", into: { animatedTitle = $0 }) {
                Utils.shared.typeText(
                    "Your daily dose of sunshine... or not!, From drizzle to sizzle, we’ve got you!",
                    into: { animatedSubtitle = $0 }
                )
            }
        }

       
    }
}

#Preview {
    LandingPageView(
        onGetStarted: { }
    )
}
