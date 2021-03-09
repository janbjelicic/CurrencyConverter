//
//  Coordinator.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import UIKit

protocol Coordinator: class {
    var childrenCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
