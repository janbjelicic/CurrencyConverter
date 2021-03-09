//
//  FakeNetworkManager.swift
//  CurrencyConverterTests
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import RxSwift
@testable import CurrencyConverter

class FakeNetworkManager: NetworkManagerProtocol {
    
    var path: String?
    var method: HttpVerb?
    var response: Data?
    
    func request<T: Codable>(request: NetworkRequest) -> Observable<T> {
        path = request.path
        method = request.method
        
        do {
            let value = try JSONDecoder().decode(T.self, from: response!)
            return Observable.just(value)
        } catch {
            return Observable.error(NetworkError.generic)
        }
    }
    
}
