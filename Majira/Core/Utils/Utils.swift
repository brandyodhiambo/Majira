//
//  Utils.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//
import Foundation
import SwiftUI
import CoreLocation

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
    
    func formattedToday() -> String {
        let today = Date()
        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEEE"
        let weekday = formatter.string(from: today)
        
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: today)

        let day = calendar.component(.day, from: today)
        let suffix: String
        switch day {
        case 11, 12, 13:
            suffix = "th"
        default:
            switch day % 10 {
            case 1: suffix = "st"
            case 2: suffix = "nd"
            case 3: suffix = "rd"
            default: suffix = "th"
            }
        }
        
        return "\(weekday), \(day)\(suffix) \(month)"
    }
    

    func getCityAndCountry(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }

            if let city = placemark.locality,
               let country = placemark.country {
                completion("\(city), \(country)")
            } else {
                completion(nil)
            }
        }
    }
    
    func calculateDaylightDuration(sunrise: Double, sunset: Double) -> String {
        let sunriseDate = Date(timeIntervalSince1970: sunrise)
        let sunsetDate = Date(timeIntervalSince1970: sunset)
        
        let duration = sunsetDate.timeIntervalSince(sunriseDate)
        
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        
        return "\(hours)h \(minutes)m"
    }



}
