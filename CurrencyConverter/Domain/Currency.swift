//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import UIKit

// EUR, GBP, RUB, PLN, RON, UAH, TRY
enum Currency: String, CaseIterable {
    
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
            return R.image.eU()?.withRenderingMode(.alwaysOriginal)
        case .britishPound:
            return R.image.gB()?.withRenderingMode(.alwaysOriginal)
        case .russianRuble:
            return R.image.rU()?.withRenderingMode(.alwaysOriginal)
        case .polishZloty:
            return R.image.pL()?.withRenderingMode(.alwaysOriginal)
        case .romanianLeu:
            return R.image.rO()?.withRenderingMode(.alwaysOriginal)
        case .ukranianHryvnia:
            return R.image.uA()?.withRenderingMode(.alwaysOriginal)
        case .turkishLira:
            return R.image.tR()?.withRenderingMode(.alwaysOriginal)
        }
    }
}
