//
//  ConvertRequest.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation

struct ConvertRequest: Encodable {
    
    let from: String
    let to: String
    let amount: Float
    
}

extension ConvertRequest: NetworkRequest {
    
    var path: String {
        "fx-rates"
    }
    
    var method: HttpVerb {
        .get
    }
    
    var parameters: [String: Any]? {
        jsonObject
    }
    
}
