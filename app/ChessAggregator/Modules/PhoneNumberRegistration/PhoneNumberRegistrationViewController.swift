//
//  PhoneNumberRegistrationViewController.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import UIKit
import FlagPhoneNumber

final class PhoneNumberRegistrationViewController: UIViewController {
	private let output: PhoneNumberRegistrationViewOutput

    private let phoneView = PhoneNumberRegistrationView()

    init(output: PhoneNumberRegistrationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = phoneView
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setup()
	}

    private func setup() {

        phoneView.numberFPNTextField.delegate = self

        phoneView.onTapNextButton = { [weak self]
        phoneNumber in
            self?.output.onTapNext(withPhoneNumber: phoneNumber)
        }
    }

    func getListFpnVC() -> FPNCountryListViewController {
        phoneView.listController
    }
}

extension PhoneNumberRegistrationViewController: PhoneNumberRegistrationViewInput {
    func showWarning(isHidden: Bool) {
        phoneView.numberWasRegisteredLabel.animatedAppearance(isHidden: isHidden)
    }
}

extension PhoneNumberRegistrationViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {

    }

    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            phoneView.nextButton.isEnabled = true
        } else {
            phoneView.nextButton.isEnabled = false
        }
    }

    func fpnDisplayCountryList() {
        output.onTapFlag()
    }

}