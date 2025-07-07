//
//  MajiraApp.swift
//  Majira
//
//  Created by MAC on 02/07/2025.
//

import SwiftUI

@main
struct MajiraApp: App {
    @StateObject var tabRouter = TabRouter()
    @AppStorage("hasStarted") var hasStarted = false

       var body: some Scene {
           WindowGroup {
               if hasStarted {
                   RootTabView()
                       .environmentObject(tabRouter)
               } else {
                   LandingPageView {
                       hasStarted = true
                   }
               }
           }
       }
}
