//
//  ConvertResponse.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation

struct ConvertResponse: Codable {
    
    let from: String
    let to: String
    let rate: Float
    let fromAmount: Float
    let toAmount: Float
    
}
