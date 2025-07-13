//
//  DataState.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import Foundation

enum DataState: Comparable{
    case good
    case isLoading
    case noResults
    case error(String)
}
