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
        self.view = phoneView
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        self.setup()
	}

    private func setup() {

        self.phoneView.numberFPNTextField.delegate = self

        self.phoneView.onTapNextButton = { [weak self]
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
        self.phoneView.numberWasRegisteredLabel.animatedAppearance(isHidden: isHidden)
    }
}

extension PhoneNumberRegistrationViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {

    }

    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            self.phoneView.nextButton.isEnabled = true
        } else {
            self.phoneView.nextButton.isEnabled = false
        }
    }

    func fpnDisplayCountryList() {
        output.onTapFlag()
    }

}