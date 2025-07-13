//
//  NetworkUtils.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import Foundation
import SwiftUI

class NetworkUtils {
    static let shared = NetworkUtils()
    
    func makeAPIRequest(
        url: URL,
        httpMethod: HttpMethod,
        postData: Any? = nil // can be a Model or JSON request
    ) async -> (Data?, URLResponse?) {
        
        var attemptsRetried = 0
        
        while true {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = httpMethod.getMethod
                request.cachePolicy = .reloadIgnoringLocalCacheData
                request.timeoutInterval = Constants.timeoutInterval
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                if let postData = postData {
                    if let dictData = postData as? [String: Any] { //MARK: JSON DATA. So serialize dictionary to JSON data
                        let jsonData = try JSONSerialization.data(withJSONObject: dictData, options: [])
                        request.httpBody = jsonData
                    }
                    else if let codableData = postData as? Encodable { //MARK: MODEL DATA. So encode Codable model
                        // Try
                        let jsonData = try JSONEncoder().encode(AnyEncodable(codableData))
                        request.httpBody = jsonData
                    }
                    else {
                        print("DEBUG: Unsupported postData type")
                        request.httpBody = Data()
                    }
                }
                
                if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                    print("DEBUG: Request Body: \(bodyString)")
                }
                
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("DEBUG: ************************************************************************************************")
                    print("DEBUG: URL: \(url)")
                    print("DEBUG: ************************************************************************************************")
                    print("DEBUG: Raw Response: \(responseString)")
                    print("DEBUG: ************************************************************************************************")
                } else {
                    print("DEBUG: ************************************************************************************************")
                    print("DEBUG: URL: \(url)")
                    print("DEBUG: ************************************************************************************************")
                    print("DEBUG: Raw Response: \(data)")
                    print("DEBUG: ************************************************************************************************")
                }
                
                return (data, response)
                
            } catch {
                let errorMessage = error.localizedDescription.lowercased()
                
                if errorMessage.contains("network connection was lost") {
                    // Handle network lost if needed
                    // NetworkMonitor.shared.isConnected = false
                }
                
                if errorMessage.contains("the request timed out"), attemptsRetried < 2 {
                    attemptsRetried += 1
                    print("DEBUG: Retrying request due to timeout, attempt \(attemptsRetried)")
                    continue // retry the request
                }
                
                print("DEBUG: API ERROR occurred. Error is \(error.localizedDescription)")
                return (nil, nil)
            }
        }
    }
}


enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
    case PATCH
    
    var getMethod: String {
        switch self {
        case .POST:
            return "POST"
        case .GET:
            return "GET"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        case .PATCH:
            return "PATCH"
        }
    }
    
}
