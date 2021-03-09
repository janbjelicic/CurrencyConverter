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

extension ConvertResponse {
    
    static let example = ConvertResponse(from: Currency.euro.rawValue,
                                         to: Currency.britishPound.rawValue,
                                         rate: 0.33,
                                         fromAmount: 1.0,
                                         toAmount: 0.8)
    
}
