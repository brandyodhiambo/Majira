//
//  CityView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityView: View {
    @EnvironmentObject var tabRouter: TabRouter
    @EnvironmentObject var themesViewModel: ThemesViewModel
    var themeToggleIcon: String {
        themesViewModel.currentTheme == .dark ? "sun.max.fill" : "moon.fill"
    }

    @State var text: String = ""
    @State var sampleCities: [CityWeather] = [
        CityWeather(cityName: "Nairobi", temperature: "23°C", iconName: "sun.max.fill",condition: "Sunny",weatherColor: .theme.sunnyYellow),
        CityWeather(cityName: "Mombasa", temperature: "29°C", iconName: "cloud.sun.fill",condition: "Sunny", weatherColor: .theme.cloudColor),
        CityWeather(cityName: "Kisumu", temperature: "26°C", iconName: "cloud.rain.fill",condition: "Sunny", weatherColor: .theme.rainColor),
        CityWeather(cityName: "Eldoret", temperature: "19°C", iconName: "cloud.fog.fill", condition: "Sunny",weatherColor: .theme.snowColor),
        CityWeather(cityName: "Nakuru", temperature: "21°C", iconName: "cloud.sun.fill",condition: "Sunny", weatherColor: .mint)
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
            trailingIcon: themeToggleIcon,
            onTrailingTap: {
                let nextTheme: ThemeModel = themesViewModel.currentTheme == .dark ? .light : .dark
                themesViewModel.changeTheme(to: nextTheme)
            }
        )
        .onAppear {
            themesViewModel.setAppTheme()
        }
    }
}

#Preview {
    NavigationView{
        CityView()
    }
}
