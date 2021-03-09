//
//  ConverterService.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import RxSwift

protocol ConverterServiceProtocol {
    
    func convert(_ request: ConvertRequest) -> Observable<ConvertResponse>
    
}

class ConverterService: ConverterServiceProtocol {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func convert(_ request: ConvertRequest) -> Observable<ConvertResponse> {
        return networkManager.request(request: request)
    }
    
}
