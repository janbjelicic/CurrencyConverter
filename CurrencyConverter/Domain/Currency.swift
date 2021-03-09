//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import UIKit

// EUR, GBP, RUB, PLN, RON, UAH, TRY
enum Currency: String {
    
    case euro = "EUR"
    case britishPound = "GBP"
    case russianRuble = "RUB"
    case polishZloty = "PLN"
    case romanianLeu = "RON"
    case ukranianHryvnia = "UAH"
    case turkishLira = "TRY"
    
    var image: UIImage? {
        switch self {
        case .euro:
            return R.image.eU()
        case .britishPound:
            return R.image.gB()
        case .russianRuble:
            return R.image.rU()
        case .polishZloty:
            return R.image.pL()
        case .romanianLeu:
            return R.image.rO()
        case .ukranianHryvnia:
            return R.image.uA()
        case .turkishLira:
            return R.image.tR()
        }
    }
}
