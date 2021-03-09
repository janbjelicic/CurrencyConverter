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

    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    
    @IBOutlet weak var txtFieldAmount: UITextField!
    @IBOutlet weak var txtFieldConvertedTo: UITextField!
    
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    private var viewModel: CurrencyConverterViewModel!
    private let disposeBag = DisposeBag()
    
    func configure(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
    }
    
    
    // MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInitialUI()
        setupBindings()
    }
    
    
    // MARK: - UI
    private func setupNavigationBar() {
        title = viewModel.title
    }
    
    private func setupInitialUI() {
        currencyPicker.isHidden = true
    }
    
    private func setupBindings() {
        // From
        viewModel.fromCurrency.asDriver().drive(onNext: { [weak self] currency in
            guard let self = self else { return }
            self.btnFrom.setTitle(currency.rawValue, for: .normal)
            self.btnFrom.setImage(currency.image, for: .normal)
        }).disposed(by: disposeBag)
        
        // To
        viewModel.toCurrency.asDriver().drive(onNext: { [weak self] currency in
            guard let self = self else { return }
            self.btnTo.setTitle(currency.rawValue, for: .normal)
            self.btnTo.setImage(currency.image, for: .normal)
        }).disposed(by: disposeBag)
        
        // Picker
        Observable.just(viewModel.currencies).bind(to: currencyPicker.rx.itemTitles) { _, currency in
            return currency.rawValue
        }
        .disposed(by: disposeBag)
        currencyPicker.rx.itemSelected
            .subscribe(onNext: { [weak self] row, _ in
                guard let self = self else { return }
                self.viewModel.updateCurrency(index: row)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Buttons
    @IBAction func btnFromOnClick(_ sender: Any) {
        currencyPicker.isHidden = false
        viewModel.pickerOpened = .from
    }
    
    @IBAction func btnToOnClick(_ sender: Any) {
        currencyPicker.isHidden = false
        viewModel.pickerOpened = .to
    }
    
    
    @IBAction func btnSwitchFromTo(_ sender: Any) {
        viewModel.switchCurrencies()
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

