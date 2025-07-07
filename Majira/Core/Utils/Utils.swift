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
    
    
    func timeLabel(for date: Date) -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        let cardHour = Calendar.current.component(.hour, from: date)

        if currentHour == cardHour {
            return "Now"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:00"
            return formatter.string(from: date)
        }
    }
}
