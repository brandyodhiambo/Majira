//
//  LocalState.swift
//  Majira
//
//  Created by Brandy Odhiambo on 09/07/2025.
//

import Foundation
import SwiftUI

enum Keys: String{
    case isFirstTimeUsingApp
    case fontPrefix
    case theme
    case isDarkModeOn
}

public class LocalState {
    @AppStorage(Keys.isFirstTimeUsingApp.rawValue) static var isFirstLaunch: Bool = true
    @AppStorage(Keys.fontPrefix.rawValue) static var selectedFontPrefix: String = "Poppins"
    @AppStorage(Keys.isDarkModeOn.rawValue) static var isDarkModeOn: String?
}
