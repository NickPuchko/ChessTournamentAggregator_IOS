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
            ratingELO, emailAddress, password,
            validatePassword, organisationCity, organisationName, birthdate in

            self?.output.onTapRegistration(lastName: lastName, firstName: firstName, patronymicName: patronymicName,
                    ratingELO: ratingELO, email: emailAddress, password: password, passwordValidation: validatePassword,
                    organisationCity: organisationCity, organisationName: organisationName, birthdate: birthdate)

        }


    }

}

extension UserRegistrationViewController: UserRegistrationViewInput {
    func hideLastNameWarning() {
        registrationView.lastNameWarning.isHidden = true
    }

    func hideFirstNameWarning() {
        registrationView.firstNameWarning.isHidden = true
    }

    func hideEmailWarning() {
        registrationView.emailAddressWarning.isHidden = true
    }

    func hidePasswordWarning() {
        registrationView.passwordWarning.isHidden = true
    }

    func hideValidatePasswordWarning() {
        registrationView.validatePasswordWarning.isHidden = true
    }

    func showLastNameWarning() {
        registrationView.lastNameWarning.isHidden = false
    }

    func showFirstNameWarning() {
        registrationView.firstNameWarning.isHidden = false
    }

    func showEmailWarning() {
        registrationView.emailAddressWarning.isHidden = false
    }

    func showPasswordWarning() {
        registrationView.passwordWarning.isHidden = false
    }

    func showValidatePasswordWarning() {
        registrationView.validatePasswordWarning.isHidden = false
    }


}

private extension UserRegistrationViewController {
    func animatedView() {

    }
}
