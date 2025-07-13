//
//  MajiraApp.swift
//  Majira
//
//  Created by Brandy Odhiambo on 02/07/2025.
//

import SwiftUI

@main
struct MajiraApp: App {
    @StateObject var tabRouter = TabRouter()
    @AppStorage("hasStarted") var hasStarted = false
    @StateObject var themesViewModel = ThemesViewModel()


       var body: some Scene {
           WindowGroup {
               if hasStarted {
                   RootTabView()
                       .environmentObject(tabRouter)
                       .environmentObject(themesViewModel)
               } else {
                   LandingPageView {
                       hasStarted = true
                   }
               }
           }
       }
}
