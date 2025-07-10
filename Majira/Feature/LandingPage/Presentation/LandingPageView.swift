//
//  LandingPageView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct LandingPageView: View {
    @StateObject var locationManager = LocationManager()
    @State var isLocationAuthorized = false
    @State var isShowRequestLocationAlert = false
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
                    if isLocationAuthorized {
                        onGetStarted()
                    }
                    else {
                        isShowRequestLocationAlert = true
                    }
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
        .onChange(of: locationManager.authorizationStatus) { newStatus in
            Task {
                if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                    isLocationAuthorized = true
                    locationManager.startUpdatingLocation()
                } else {
                    isLocationAuthorized = false
                }
            }
        }
        .alert(isPresented: $isShowRequestLocationAlert) {
            Alert(
                title: Text("Location permision is required to proceed"),
                message: Text("Please enable location access in settings to proceed."),
                primaryButton: .default(Text("Open Settings")) {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                },
                secondaryButton: .cancel()
            )
        }
        
    }
}

#Preview {
    LandingPageView(
        onGetStarted: { }
    )
}
