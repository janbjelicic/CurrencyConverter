//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import RxSwift

class CurrencyConverterViewModel {
    
    let title = "Currency Converter"
    
    private let converterService: ConverterServiceProtocol
    
    init(converterService: ConverterServiceProtocol) {
        self.converterService = converterService
    }
    
    func convert() -> Observable<ConvertResponse> {
        return converterService.convert(ConvertRequest(from: "EUR", to: "GBP", amount: 4.0))
    }
    
}
