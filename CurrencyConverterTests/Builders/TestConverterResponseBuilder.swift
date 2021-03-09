//
//  TestConverterResponseBuilder.swift
//  CurrencyConverterTests
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
@testable import CurrencyConverter

struct TestConverterResponseBuilder {
    
    static func getConverterResponse() -> Data? {
        do {
            let data = try JSONEncoder().encode(ConvertResponse.example)
            return data
        } catch {
            return nil
        }
    }
    
}
