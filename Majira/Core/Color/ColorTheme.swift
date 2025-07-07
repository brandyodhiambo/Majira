//
//  ColorTheme.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI
import Foundation

struct ColorTheme{
    let primaryColor = Color("PrimaryColor")
    let onPrimaryColor = Color("WhiteColor")
    
    let surfaceColor = Color("SurfaceColor")
    let onSurfaceColor = Color("OnSurfaceColor")
    
    let errorColor = Color("RedColor")
    let onErrorColor = Color("WhiteColor")
    
    let successColor = Color("GreenColor")
    let warningColor = Color("YellowColor")
    
    let sunnyYellow = Color("SunnyColor")
    let cloudColor = Color("CloudColor")
    let rainColor = Color("RainColor")
    let nightColor = Color("NightColor")
    let snowColor = Color("SnowColor")
}

extension Color{
    static var theme = ColorTheme()
}
