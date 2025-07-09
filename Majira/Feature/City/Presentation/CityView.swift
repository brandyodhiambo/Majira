//
//  CityView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityView: View {
    @EnvironmentObject var tabRouter: TabRouter

    @State var text: String = ""
    @State var sampleCities: [City] = [
        City(cityName: "Nairobi", temperature: "23°", iconName: "sun.max.fill", weatherColor: .theme.sunnyYellow),
        City(cityName: "Mombasa", temperature: "29°", iconName: "cloud.sun.fill", weatherColor: .theme.cloudColor),
        City(cityName: "Kisumu", temperature: "26°", iconName: "cloud.rain.fill", weatherColor: .theme.rainColor),
        City(cityName: "Eldoret", temperature: "19°", iconName: "cloud.fog.fill", weatherColor: .theme.snowColor),
        City(cityName: "Nakuru", temperature: "21°", iconName: "cloud.sun.fill", weatherColor: .mint)
    ]
    
    var body: some View {
        let router = tabRouter.cityRouter
        VStack(alignment:.leading,spacing:16){
            InputFieldView(
                image:"",
                placeHolder: "Search City",
                text: $text,
                inputFieldStyle: .outlined
            )
            
            Text("My Cities")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(.theme.onSurfaceColor.opacity(0.7))
            
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 12) {
                    ForEach(sampleCities, id: \.cityName) { city in
                        CityCardView(
                            cityName: city.cityName,
                            temperature: city.temperature,
                            iconName: city.iconName,
                            weatherColor: city.weatherColor,
                            onTap: {
                                print("tapped city: \(city.cityName)")
                                router.push(.cityDetails(city: city))
                            }
                        )
                    }
                }
            }
        }
        .padding()
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "Choose City",
            leadingIcon: "",
            navbarTitleDisplayMode: .inline,
            onLeadingTap: {},
            trailingIcon: "moon.fill",
            onTrailingTap: {
                
            }
        )
    }
}

#Preview {
    NavigationView{
        CityView()
    }
}
