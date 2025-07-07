//
//  RouteTabView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//
import SwiftUI

struct RootTabView: View {
    @EnvironmentObject var tabRouter: TabRouter
    
    let tabBackgroundColor = Color.theme.surfaceColor
    let selectedColor = Color.theme.primaryColor

    var body: some View {
        ZStack {
            TabView(selection: $tabRouter.selectedTab) {
                TabNavigationView(router: tabRouter.homeRouter) {
                    HomeView()
                }
                .tag(TabRouter.Tab.home)

                TabNavigationView(router: tabRouter.forecastRouter) {
                    ForeCastView()
                }
                .tag(TabRouter.Tab.forecast)

                TabNavigationView(router: tabRouter.cityRouter) {
                    CityView()
                }
                .tag(TabRouter.Tab.city)
            }
            .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                HStack {
                    ForEach(TabRouter.Tab.allCases, id: \.self) { tab in
                        Spacer()

                        Button(action: {
                            tabRouter.selectedTab = tab
                        }) {
                            VStack(spacing: 4) {
                                Image(systemName: tab.iconName)
                                    .font(.system(size: 20, weight: .bold))
                                Text(tab.title)
                                    .font(.caption2)
                            }
                            .foregroundColor(tabRouter.selectedTab == tab ? selectedColor : .gray)
                        }

                        Spacer()
                    }
                }
                .padding(.vertical, 12)
                .background(
                    tabBackgroundColor
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .theme.onSurfaceColor.opacity(0.1), radius: 8, x: 0, y: 4)
                )
                .padding(.horizontal, 15)
                .padding(.bottom, 24)
            }
        }
    }
}


struct TabNavigationView<Content: View>: View {
    @ObservedObject var router: Router
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Route.self) { route in
                    viewForRoute(route, router: router)
                }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(TabRouter())
}
