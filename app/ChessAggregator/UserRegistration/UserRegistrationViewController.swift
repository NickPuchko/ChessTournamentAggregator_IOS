//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import UIKit

class UserRegistrationViewController: UIViewController {
    let output: UserRegistrationViewOutput

    private let registrationView = UserRegistrationPlayerView()

    init(output: UserRegistrationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboard")
    }

    override func loadView() {
        self.view = registrationView
        self.view.backgroundColor = .systemGray6
        self.setup()
    }

    private func setup() {
        registrationView.onTapRegistrationButton = { [weak self]
            lastName, firstName, patronymicName,
            FideID, CFRID, emailAddress, password, validatePassword,
            isOrganizer, organisationCity, organisationName,
            birthdate in

            self?.output.onTapRegistration(
                    lastName: lastName, firstName: firstName, patronymicName: patronymicName, FideID: FideID,
                    CFRID: CFRID, email: emailAddress, password: password, passwordValidation: validatePassword,
                    isOrganizer: isOrganizer, organizationCity: organisationCity, organizationName: organisationName,
                    birthdate: birthdate
            )

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(UserRegistrationViewController.keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
        )
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(UserRegistrationViewController.keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
        )
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize: CGRect =
        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(
                top: 0.0, left: 0.0,
                bottom: keyboardSize.height + registrationView.registrationOffset, right: 0.0
        )
        registrationView.scrollableStackView.set(contentInset: contentInsets)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        registrationView.scrollableStackView.set(contentInset: .zero)
    }
}

extension UserRegistrationViewController: UserRegistrationViewInput {

    func showLastNameWarning(isHidden: Bool) {
        registrationView.lastNameWarning.isHidden = isHidden
    }

    func showFirstNameWarning(isHidden: Bool) {
        registrationView.firstNameWarning.isHidden = isHidden
    }

    func showEmailWarning(isHidden: Bool) {
        registrationView.emailAddressWarning.isHidden = isHidden
    }

    func showPasswordWarning(isHidden: Bool) {
        registrationView.passwordWarning.isHidden = isHidden
    }

    func showValidatePasswordWarning(isHidden: Bool) {
        registrationView.validatePasswordWarning.isHidden = isHidden
    }

    func showOrganizationNameWarning(isHidden: Bool) {
        registrationView.organizationNameWarning.isHidden = isHidden
    }

}

private extension UserRegistrationViewController {
    func animatedView() {

    }
}

extension UserRegistrationViewController: UITextFieldDelegate {

}
