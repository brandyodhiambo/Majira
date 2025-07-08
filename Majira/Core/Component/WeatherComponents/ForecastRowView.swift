//
//  ForecastRowView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//
import SwiftUI
import SwiftUI

struct ForecastRowView: View {
    let day: String
    let date:String
    let icon: String
    let temperature: String
    let weatherColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(day)
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .foregroundColor(Color.theme.onSurfaceColor)
                Text(date)
                    .font(.custom("Poppins-Light", size: 12))
                    .foregroundColor(Color.theme.onSurfaceColor.opacity(0.7))
            }
            
            Spacer()
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(weatherColor)
            
            Text(temperature)
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundColor(Color.theme.onSurfaceColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme.surfaceColor)
                .shadow(color: Color.theme.onSurfaceColor.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 8)
    }
}


struct ForecastRowViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            ForecastRowView(
                day: "Monday",
                date: "July, 07",
                icon: "cloud.sun.fill",
                temperature: "23°",
                weatherColor: .theme.cloudColor
            )
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)
            
            ForecastRowView(
                day: "Monday",
                date: "July, 07",
                icon: "cloud.sun.fill",
                temperature: "23°",
                weatherColor: .theme.sunnyYellow
            )
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}



