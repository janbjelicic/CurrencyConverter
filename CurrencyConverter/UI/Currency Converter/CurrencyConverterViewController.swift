//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    private var viewModel: CurrencyConverterViewModel!
    
    func configure(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

