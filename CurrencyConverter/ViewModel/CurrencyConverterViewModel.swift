//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum PickerOpened {
    case from
    case to
    case none
}

class CurrencyConverterViewModel {
    
    let title = "Currency Converter"
    
    private let converterService: ConverterServiceProtocol
    private var convertResponse: ConvertResponse?
    let currencies: [Currency]
    
    let fromCurrency: BehaviorRelay<Currency>
    let toCurrency: BehaviorRelay<Currency>
    var pickerOpened: PickerOpened
    
    init(converterService: ConverterServiceProtocol) {
        self.converterService = converterService
        self.currencies = Currency.allCases
        self.fromCurrency = BehaviorRelay(value: Currency.euro)
        self.toCurrency = BehaviorRelay(value: Currency.britishPound)
        self.pickerOpened = .none
    }
    
    func updateCurrency(index: Int) {
        if pickerOpened == .from {
            fromCurrency.accept(currencies[index])
        } else if pickerOpened == .to {
            toCurrency.accept(currencies[index])
        }
    }
    
    func switchCurrencies() {
        let fromCurrencyValue = fromCurrency.value
        fromCurrency.accept(toCurrency.value)
        toCurrency.accept(fromCurrencyValue)
    }
    
    func convert(amount: Float) -> Observable<ConvertResponse> {
        return converterService.convert(ConvertRequest(from: fromCurrency.value.rawValue, to: toCurrency.value.rawValue, amount: amount)).map { response in
            #warning("Memory leak fix")
            //guard let self = self else { return nil }
            self.convertResponse = response
            return response
        }
    }
    
}
