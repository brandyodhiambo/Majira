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

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(tabRouter)
        }
    }
}
