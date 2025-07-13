//
//  LocalState.swift
//  Majira
//
//  Created by Brandy Odhiambo on 09/07/2025.
//

import Foundation
import SwiftUI

enum Keys: String{
    case isDarkModeOn
}

public class LocalState {
    @AppStorage(Keys.isDarkModeOn.rawValue) static var isDarkModeOn: String?
}
