//
//  TabRouter.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

class TabRouter: ObservableObject{
    @Published var selectedTab: Tab = .home
    
    var homeRouter = Router()
    var forecastRouter = Router()
    var cityRouter = Router()
    
    enum Tab{
        case home, forecast, city
    }
    
    func router(for tab: Tab) -> Router{
        switch tab {
        case .home:
            return homeRouter
        case .forecast:
            return forecastRouter
        case .city:
            return cityRouter
        }
    }

}

extension TabRouter.Tab: CaseIterable {
    var title: String {
        switch self {
        case .home: return "Home"
        case .forecast: return "Forecast"
        case .city: return "City"
        }
    }

    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .forecast: return "chart.bar.fill"
        case .city: return "magnifyingglass"
        }
    }
}



@ViewBuilder
func viewForRoute(_ route: Route, router: Router) -> some View{
    switch route {
    case .landingPage:
        LandingPageView()
        
    case .home:
        HomeView()

    case .forecast:
        ForeCastView()
            .environmentObject(router)

    case .city:
        CityView()
            .environmentObject(router)

    case .cityDetails(let city):
        CityWeatherDetailsView(city: city)
            .navigationBarBackButtonHidden()
            .environmentObject(router)

    }
}
