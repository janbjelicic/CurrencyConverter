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

    #warning("Add currency labels at the end of the text fields")
    #warning("Add network activity indicator to see that a network request is happening")
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    
    @IBOutlet weak var txtFieldAmount: UITextField!
    @IBOutlet weak var txtFieldConvertedTo: UITextField!
    
    @IBOutlet weak var viewConverted: UIView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                 action: #selector(backgroundTap))
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.removeGestureRecognizer(tapGesture)
    }
    
    // MARK: - Tap
    @objc func backgroundTap() {
        currencyPicker.isHidden = true
        txtFieldAmount.resignFirstResponder()
        txtFieldConvertedTo.resignFirstResponder()
    }
    
    // MARK: - UI
    private func setupNavigationBar() {
        title = viewModel.title
    }
    
    private func setupInitialUI() {
        viewConverted.isHidden = true
        currencyPicker.isHidden = true
        txtFieldAmount.addDoneCancelToolbar()
        txtFieldConvertedTo.addDoneCancelToolbar()
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
        
        bindTextFields()
        
        // Picker
        Observable.just(viewModel.currencies).bind(to: currencyPicker.rx.itemTitles) { _, currency in
            return currency.rawValue
        }
        .disposed(by: disposeBag)
        currencyPicker.rx.itemSelected
            .subscribe(onNext: { [weak self] row, _ in
                guard let self = self else { return }
                self.viewModel.updateCurrency(index: row)
                self.viewConverted.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTextFields() {
        // Amount
        txtFieldAmount
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(txtFieldAmount.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                guard let rate = self.viewModel.rate, let amount = Float(text) else {
                    self.txtFieldConvertedTo.text = ""
                    return
                }
                self.txtFieldConvertedTo.text = String(amount * rate)
            })
            .disposed(by: disposeBag)
        
        // Converted To
        txtFieldConvertedTo
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(txtFieldConvertedTo.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                guard let rate = self.viewModel.rate, let convertedTo = Float(text) else {
                    self.txtFieldAmount.text = ""
                    return
                }
                self.txtFieldAmount.text = String(convertedTo / rate)
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
        let amount = txtFieldAmount.text
        txtFieldAmount.text = txtFieldConvertedTo.text
        txtFieldConvertedTo.text = amount
    }
    
    @IBAction func btnConvertOnClick(_ sender: Any) {
        backgroundTap()
        guard let text = txtFieldAmount.text, let amount = Float(text) else { return }
        viewModel.convert(amount: amount)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self, let response = response else { return }
                self.txtFieldConvertedTo.text = String(response.toAmount)
                // Rate could have been also tied through a label.rx binding
                // but I wanted to show-case observing on the observe(on: MainScheduler.instance) here.
                self.lblRate.text = self.viewModel.rateText
                self.viewConverted.isHidden = false
                print(response)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                print(error)
                self.presentErrorAlert()
            }).disposed(by: disposeBag)
    }
    
    // I consider alerts also a part of navigation so this could be added to a "router" class
    // MARK: - Alert
    func presentErrorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Error occurred, try again later",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
