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
    
    func typeText(_ fullText: String, into target: @escaping (String) -> Void, speed: Double = 0.05, completion: @escaping () -> Void = {}) {
        var currentText = ""
        for (index, char) in fullText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + speed * Double(index)) {
                currentText.append(char)
                target(currentText)

                if index == fullText.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        completion()
                    }
                }
            }
        }
    }
}
