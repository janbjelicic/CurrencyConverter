//
//  AppCoordinator.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    var childrenCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        guard let currencyConverterViewController =
                R.storyboard.main.currencyConverterViewControllerID() else { return }
        // Network manager would be usually shared but for simplicity lets leave it like this for now.
        let networkManager = NetworkManager()
        let converterService = ConverterService(networkManager: networkManager)
        let currencyConverterViewModel = CurrencyConverterViewModel(converterService: converterService)
        currencyConverterViewController.configure(viewModel: currencyConverterViewModel)
        navigationController.pushViewController(currencyConverterViewController, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
