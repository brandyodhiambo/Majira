//
//  NetworkError.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible{
    case badURL
    case urlSession(Error)
    case badResponse(Int)
    case decoding(DecodingError)
    case custom(String)
    case smthWentWrong
    case unkown
    case unexpected
    
    var description: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .urlSession(let error):
            return "\(error.localizedDescription)"
        case .badResponse(let statusCode):
            return "Unexpected error occurred, please try again."
        case .decoding(let decodingError):
            return "Unexpected error occurred, please try again."
        case .custom(let error):
            return error
        case .smthWentWrong:
            return "Oops! Something went wrong, please try again."
        case .unkown:
            return "Unknown error, please try again."
        case .unexpected:
            return "Unexpected error occurred, kindly try again."
        }
    }
}
