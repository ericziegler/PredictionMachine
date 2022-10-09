//
//  NumberInputViewController.swift
//  RackScan
//
//  Created by Eric Ziegler on 9/13/22.
//

import UIKit

class NumberInputViewController: BaseModalViewController, UITextFieldDelegate {
 
    // MARK: - Properties
    
    private static let storyboardName = "NumberInput"
    private static let storyboardId = "NumberInputViewId"
    
    @IBOutlet var currencyLabel: LightLabel!
    @IBOutlet var currencyWidthConstraint: NSLayoutConstraint!
    @IBOutlet var inputField: UITextField!
    
    var inputSavedBlock: ((_ number: NSNumber?) -> ())?
    
    private var viewModel = NumberInputViewModel()
    
    // MARK: - Init
    
    static func createController(with number: NSNumber?, placeholder: String?, isCurrency: Bool, isDecimal: Bool, title: String) -> NumberInputViewController {
        let storyboard = UIStoryboard(name: NumberInputViewController.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: NumberInputViewController.storyboardId) as! NumberInputViewController
        controller.viewModel = NumberInputViewModel(number: number, placeholder: placeholder, isDecimal: isDecimal, isCurrency: isCurrency)
        controller.title = title
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputField()
        styleUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputField.becomeFirstResponder()
        inputField.selectAll(nil)
    }
    
    private func setupInputField() {
        inputField.placeholder = viewModel.placeholder
        inputField.text = viewModel.numberAsText
        if viewModel.isDecimal == true {
            inputField.keyboardType = .decimalPad
        } else {
            inputField.keyboardType = .numberPad
        }
    }
    
    private func styleUI() {
        if viewModel.isCurrency == false {
            currencyWidthConstraint.constant = 0
        }
    }
    
    // MARK: - Helpers
    
    private func checkPromptClose() {
        if viewModel.changesMade(curText: inputField.text) {
            showCloseWarning()
        } else {
            self.dismiss(animated: true)
        }
    }
    
    private func saveInput() {
        if viewModel.checkValidInput(text: inputField.text) == false {
            showAlert(title: "Uh oh!", message: "It looks like the value you entered is not a number. Please review your entry.")
        } else {
            inputSavedBlock?(viewModel.textToNumber(inputField.text))
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - Actions
    
    @objc override func closeTapped(_ sender: AnyObject) {
        checkPromptClose()
    }
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        saveInput()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveInput()
        return true
    }
    
}
