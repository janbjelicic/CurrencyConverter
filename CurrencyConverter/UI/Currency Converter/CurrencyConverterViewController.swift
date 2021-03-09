//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyConverterViewController: UIViewController {

    @IBOutlet weak var txtFieldAmount: UITextField!
    @IBOutlet weak var txtFieldConvertedTo: UITextField!
    
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnConvert: UIButton!
    
    
    private var viewModel: CurrencyConverterViewModel!
    private let disposeBag = DisposeBag()
    
    func configure(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = viewModel.title
    }
    
    // MARK: - Buttons
    @IBAction func btnSwitchFromTo(_ sender: Any) {
        
    }
    
    @IBAction func btnConvertOnClick(_ sender: Any) {
        viewModel.convert()
            //.observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                print(response)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    

}

