//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import UIKit

class UserRegistrationViewController: UIViewController {
    let output: UserRegistrationViewOutput

    private let registrationView = UserRegistrationPlayerView()

    private lazy var adapter = KeyboardAdapter(window: self.view.window) { [weak self] offset, duration in
        self?.keyboardOffsetChanged(offset, duration: duration)
    }

    init(output: UserRegistrationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboard")
    }

    override func loadView() {
        self.view = registrationView
        self.view.backgroundColor = .white
        self.setup()
    }

    private func setup() {
        registrationView.onTapRegistrationButton = { [weak self]
        lastName, firstName, patronymicName,
        fideID, frcID, emailAddress, password, validatePassword,
        isOrganizer, organisationCity, organisationName,
        birthdate, sex in

            self?.output.onTapRegistration(
                    lastName: lastName, firstName: firstName, patronymicName: patronymicName, fideID: fideID,
                    frcID: frcID, email: emailAddress, password: password, passwordValidation: validatePassword,
                    isOrganizer: isOrganizer, organizationCity: organisationCity, organizationName: organisationName,
                    birthdate: birthdate, sex: sex
                
            )

        }

        registrationView.onTapFideButton = { [weak self] in
            self?.output.onTapFide()
        }

        registrationView.onTapFrcButton = { [weak self] in
            self?.output.onTapFrc()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация"
        initializeHideKeyboard()
        initializeTextFieldDelegates()
//        self.registrationView.sexPicker.delegate = self
//        self.registrationView.sexPicker.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adapter.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        adapter.stop()
    }

}

extension UserRegistrationViewController: UserRegistrationViewInput {
    func showEmailWasRegisteredWarning(withWarning warning: String, isHidden: Bool) {
        registrationView.emailWasRegisteredWarning.text = warning
        registrationView.emailWasRegisteredWarning.isHidden = isHidden
    }


    func showLastNameWarning(isHidden: Bool) {
        registrationView.lastNameWarning.animatedAppearance(isHidden: isHidden)
    }

    func showFirstNameWarning(isHidden: Bool) {
        registrationView.firstNameWarning.animatedAppearance(isHidden: isHidden)
    }

    func showEmailWarning(isHidden: Bool) {
        registrationView.emailAddressWarning.animatedAppearance(isHidden: isHidden)
    }

    func showPasswordWarning(isHidden: Bool) {
        registrationView.passwordWarning.animatedAppearance(isHidden: isHidden)
    }

    func showValidatePasswordWarning(isHidden: Bool) {
        registrationView.validatePasswordWarning.animatedAppearance(isHidden: isHidden)
    }

    func showOrganizationNameWarning(isHidden: Bool) {
        registrationView.organizationNameWarning.animatedAppearance(isHidden: isHidden)
    }

}

extension UserRegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
            return true
        }

        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)

        switch textField {
        case registrationView.lastName, registrationView.firstName, registrationView.patronymicName:
            return self.output.isFullNameOK(string: prospectiveText)
        case registrationView.fideID, registrationView.frcID:
            let (isAllowedToChange, number) = self.output.filterID(string: prospectiveText, maxID: registrationView.maxValueOfId)
            if let num = number {
                textField.text = "\(num)"
            }
            return isAllowedToChange
        case registrationView.emailAddress, registrationView.password, registrationView.validatePassword:
            return self.output.isLoginDataOK(string: prospectiveText)
        case registrationView.organizationName, registrationView.organizationCity:
                return self.output.isOrganizationDataOK(string: prospectiveText)
        case registrationView.sex:
            return self.output.isSexOK(string: prospectiveText)
        default:
            return true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


private extension UserRegistrationViewController {
    func keyboardOffsetChanged(_ offset: CGFloat, duration: TimeInterval) {
        let contentInsets = UIEdgeInsets(
                top: 0.0, left: 0.0,
                bottom: offset + registrationView.registrationOffset, right: 0.0
        )
        registrationView.scrollableStackView.set(contentInset: contentInsets)
    }

    func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tap)
    }

    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }

    func initializeTextFieldDelegates() {
        self.registrationView.lastName.delegate = self
        self.registrationView.firstName.delegate = self
        self.registrationView.patronymicName.delegate = self
        self.registrationView.fideID.delegate = self
        self.registrationView.frcID.delegate = self
        self.registrationView.emailAddress.delegate = self
        self.registrationView.password.delegate = self
        self.registrationView.validatePassword.delegate = self
        self.registrationView.organizationCity.delegate = self
        self.registrationView.organizationName.delegate = self
       // self.registrationView.sex.delegate = self
    }

}

extension UserRegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        registrationView.sexList.count
    }
}

extension UserRegistrationViewController: UIPickerViewDelegate {

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        registrationView.sexList[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        registrationView.selectedSex = registrationView.sexList[row]
//        registrationView.sex.text = registrationView.selectedSex
//    }
}
