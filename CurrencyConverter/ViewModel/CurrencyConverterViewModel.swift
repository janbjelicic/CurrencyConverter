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
    
//    let user: Driver<User>
//
//    init(coordinator: Coordinator, user: User) {
//        self.coordinator = coordinator
//        self.user = BehaviorRelay(value: user).asDriver()
//    }
    
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
    
    func convert() -> Observable<ConvertResponse> {
        return converterService.convert(ConvertRequest(from: "EUR", to: "GBP", amount: 4.0)).map { response in
            #warning("Memory leak fix")
            //guard let self = self else { return nil }
            self.convertResponse = response
            return response
        }
    }
    
}
