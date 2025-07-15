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
    
    

    func weatherImage(for iconCode: String) -> Image {
        let assetName: String
        switch iconCode {
        case "02n":
            assetName = "partlyCloudy"       // few clouds night
        case "02d":                             // few clouds day
            assetName = "sunCloud"
        case "01d":                      // clear / few clouds day
            assetName = "sun"
        case "03d", "04d", "03n", "04n":  // scattered / broken clouds
            assetName = "cloud"
            
        case "09d", "09n", "10n":               // shower rain / rain night
            assetName = "rain"
            
        case "10d":                             // rain day (sun + rain)
            assetName = "sunRain"
            
        case "11d", "11n":                      // thunderstorm
            assetName = "thunder_lightning"
            
        case "13d", "13n":                      // snow
            assetName = "snow"
            
        case "50d", "50n":                      // mist / fog
            assetName = "fog"
            
        case "01n":                             // clear night
            assetName = "clear"
            
        default:                                // fallback
            assetName = "cloud"
        }
        
        return Image(assetName)
    }
    
    
    func mapIconToSFImage(icon: String) -> String {
        switch icon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.rain.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "cloud.fill"
        }
    }
    

    func weatherColor(for condition: String) -> Color {
        switch condition.lowercased() {
        case "rain": return .theme.rainColor
        case "clear": return Color.orange
        case "clouds" , "broken clouds": return .theme.cloudColor
        case "snow": return Color.theme.snowColor
        case "sun": return .theme.sunnyYellow
        default: return Color.theme.primaryColor
        }
    }





}
