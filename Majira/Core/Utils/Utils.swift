//
//  Utils.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//
import Foundation
import SwiftUI

struct Utils {
    static let shared = Utils()
       // Dismiss keyboard
       func endEditing() {
              UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
          }
}
